#!/usr/bin/env bash

set -euo pipefail

script_dir="$(dirname "$(readlink -f "$0")")"
ROOT="$HOME/dotfiles"

mkdir -p "$ROOT"

while IFS=, read -r name target; do
    target="$(sed 's/^[[:space:]]*//;s/[[:space:]]*$//' <<<"$target")"
    if [[ ! -d "$ROOT/$name/.git" ]]; then
        git clone "git@github.com:kennethlieyanto/$name.git" "$ROOT/$name"
    fi
done < "$script_dir/repo-list.txt"

# Build lookup: repo name -> stow target
declare -A stow_targets
while IFS=, read -r name target; do
    target="$(sed 's/^[[:space:]]*//;s/[[:space:]]*$//' <<<"$target")"
    stow_targets["$name"]="$target"
done < "$script_dir/repo-list.txt"

# Select machine
machine_file="$script_dir/.current-machine"
if [[ -f "$machine_file" ]]; then
    machine="$(<"$machine_file")"
    echo "Using cached machine: $machine"
else
    echo "Select a machine configuration:"
    machines=("$script_dir/machines"/*/)
    machines=("${machines[@]%/}")
    machines=("${machines[@]##*/}")
    select machine in "${machines[@]}"; do
        if [[ -n "$machine" ]]; then
            echo "$machine" > "$machine_file"
            echo "Selected: $machine"
            break
        fi
    done
fi

# Stow entries from machine's stow-list.txt
stow_list="$script_dir/machines/$machine/stow-list.txt"
if [[ -f "$stow_list" ]]; then
    while IFS= read -r name; do
        name="${name%%#*}"  # strip inline comments
        name="${name//[[:space:]]/}"
        [[ -z "$name" ]] && continue
        target="${stow_targets[$name]:-}"
        if [[ -z "$target" ]]; then
            echo "Warning: No target for '$name' in repo-list.txt, skipping"
            continue
        fi
        target_expanded="${target/#\~/$HOME}"
        mkdir -p "$target_expanded"
        echo "Stowing $name -> $target"
        stow -d "$ROOT" -t "$target_expanded" "$name"
    done < "$stow_list"
else
    echo "No stow-list.txt for machine '$machine'"
fi

# Regenerate .gitignore from repo-list.txt
names=()
while IFS=, read -r name _; do
    names+=("$name")
done < "$script_dir/repo-list.txt"
printf '%s\n' \
    '# Auto-generated from repo-list.txt — do not edit directly.' \
    '# Run bootstrap.sh to regenerate.' \
    > "$script_dir/.gitignore"
printf '/%s/\n' "${names[@]}" >> "$script_dir/.gitignore"
echo '.current-machine' >> "$script_dir/.gitignore"
