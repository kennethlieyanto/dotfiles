#!/usr/bin/env python3

import os
import re
from datetime import datetime
from pathlib import Path

# Configuration
OBSIDIAN_VAULT_PATH = Path.home() / "Vaults" / "notes"
DAILY_NOTES_PATH = OBSIDIAN_VAULT_PATH / "dailies"
MAX_RECURSION_DEPTH = 5

def get_daily_note_file():
    """Get today's daily note filename"""
    today = datetime.now().strftime("%Y-%m-%d")
    return DAILY_NOTES_PATH / f"{today}.md"

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
                referenced_file = OBSIDIAN_VAULT_PATH / f"{note_ref}.md"
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

def main():
    """Main function"""
    daily_note_file = get_daily_note_file()
    
    # Debug: Check if daily note exists
    if not daily_note_file.exists():
        print(f"Daily note not found: {daily_note_file}")
        return
    
    task = get_first_unchecked_task(daily_note_file, 0)
    
    if task:
        # Truncate if too long for polybar
        if len(task) > 50:
            print(f"{task[:47]}...")
        else:
            print(task)
    else:
        print("No tasks")

if __name__ == "__main__":
    main()
