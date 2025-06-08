#!/usr/bin/env python3
import os
import re
import json
import subprocess
from datetime import datetime
from pathlib import Path

# Configuration
VAULTS_BASE_PATH = Path.home() / "Vaults"
CONFIG_FILE = Path.home() / ".config" / "obsidian-task-config.json"
MAX_RECURSION_DEPTH = 5

def load_config():
    """Load current vault configuration"""
    default_config = {"current_vault": "notes"}  # Default to 'notes'
    
    if CONFIG_FILE.exists():
        try:
            with open(CONFIG_FILE, 'r') as f:
                return json.load(f)
        except (json.JSONDecodeError, IOError):
            pass
    return default_config

def save_config(config):
    """Save vault configuration"""
    CONFIG_FILE.parent.mkdir(parents=True, exist_ok=True)
    try:
        with open(CONFIG_FILE, 'w') as f:
            json.dump(config, f, indent=2)
    except IOError:
        pass

def get_available_vaults():
    """Get list of available vaults"""
    if not VAULTS_BASE_PATH.exists():
        return []
    return [d.name for d in VAULTS_BASE_PATH.iterdir() if d.is_dir() and not d.name.startswith('.')]

def select_vault_with_rofi():
    """Use rofi to select a vault"""
    vaults = get_available_vaults()
    if not vaults:
        return None
    
    try:
        result = subprocess.run(
            ['rofi', '-dmenu', '-p', 'Select Vault:', '-format', 's'],
            input='\n'.join(vaults),
            text=True,
            capture_output=True,
            check=True
        )
        selected = result.stdout.strip()
        return selected if selected in vaults else None
    except (subprocess.CalledProcessError, FileNotFoundError):
        return None

def get_current_vault_paths():
    """Get current vault and daily notes paths"""
    config = load_config()
    current_vault = config.get("current_vault", "notes")
    
    vault_path = VAULTS_BASE_PATH / current_vault
    daily_notes_path = vault_path / "dailies"
    
    return vault_path, daily_notes_path

def get_daily_note_file():
    """Get today's daily note filename"""
    today = datetime.now().strftime("%Y-%m-%d")
    _, daily_notes_path = get_current_vault_paths()
    return daily_notes_path / f"{today}.md"

def extract_note_reference(task_text):
    """Extract note reference from [[note-reference]] format"""
    match = re.search(r'\[\[([^\]]+)\]\]', task_text)
    return match.group(1) if match else None

def clean_task_text(text):
    """Remove metadata and clean up task text"""
    # Remove created/completion metadata
    text = re.sub(r'\s*\[created::.*?\]', '', text)
    text = re.sub(r'\s*\[completion::.*?\]', '', text)
    return text.strip()

def get_first_unchecked_task(file_path, depth=0):
    """
    Extract the first unchecked task from a file
    Returns the task text without markdown formatting
    """
    # Prevent infinite recursion
    if depth > MAX_RECURSION_DEPTH:
        return None
    
    # Check if file exists
    if not file_path.exists():
        return None
    
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            lines = f.readlines()
    except (IOError, UnicodeDecodeError):
        return None
    
    # Get current vault path for reference resolution
    vault_path, _ = get_current_vault_paths()
    
    # Find the first unchecked task
    for line in lines:
        line = line.strip()
        if line.startswith('- [ ]'):
            # Extract task text (everything after "- [ ] ")
            task_text = line[5:].strip()  # Remove "- [ ] "
            
            # Clean metadata first
            task_text = clean_task_text(task_text)
            
            # Check if this is a reference to another note
            note_ref = extract_note_reference(task_text)
            if note_ref:
                # Try to get task from referenced file
                referenced_file = vault_path / f"{note_ref}.md"
                referenced_task = get_first_unchecked_task(referenced_file, depth + 1)
                
                if referenced_task:
                    return referenced_task
                else:
                    # If referenced file has no tasks, return the reference name
                    # Extract just the note name, handling timestamp prefixes
                    if '-' in note_ref and note_ref.split('-', 1)[0].isdigit():
                        # Format like "1749281118-fedora-i3-config"
                        return note_ref.split('-', 1)[1].replace('-', ' ')
                    else:
                        return note_ref.replace('-', ' ')
            else:
                # Regular task, return the text
                return task_text
    
    return None

def switch_vault():
    """Switch to a different vault using rofi"""
    selected_vault = select_vault_with_rofi()
    if selected_vault:
        config = load_config()
        config["current_vault"] = selected_vault
        save_config(config)
        print(f"Switched to vault: {selected_vault}")
    else:
        print("No vault selected")

def main():
    """Main function"""
    # Handle vault switching
    if len(os.sys.argv) > 1 and os.sys.argv[1] == "--switch":
        switch_vault()
        return
    
    # Show current vault if requested
    if len(os.sys.argv) > 1 and os.sys.argv[1] == "--current":
        config = load_config()
        print(f"Current vault: {config.get('current_vault', 'notes')}")
        return
    
    daily_note_file = get_daily_note_file()
    
    # Debug: Check if daily note exists
    if not daily_note_file.exists():
        config = load_config()
        current_vault = config.get('current_vault', 'notes')
        print(f"Daily note not found in vault '{current_vault}': {daily_note_file}")
        return
    
    task = get_first_unchecked_task(daily_note_file, 0)
    
    if task:
        # Truncate if too long for polybar
        if len(task) > 90:
            print(f"{task[:47]}...")
        else:
            print(task)
    else:
        print("No tasks")

if __name__ == "__main__":
    main()
