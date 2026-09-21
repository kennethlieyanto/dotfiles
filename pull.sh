#!/usr/bin/env bash

set -uo pipefail

script_dir="$(dirname "$(readlink -f "$0")")"
ROOT="$HOME/dotfiles"
JOBS="${PULL_JOBS:-4}"

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

names=()
while IFS=, read -r name _; do
    name="${name//[[:space:]]/}"
    [[ -z "$name" ]] && continue
    if [[ -d "$ROOT/$name/.git" ]]; then
        names+=("$name")
    else
        echo "Warning: $ROOT/$name is not a git repo, skipping"
    fi
done < "$script_dir/repo-list.txt"

if (( ${#names[@]} == 0 )); then
    echo "Nothing to pull."
    exit 0
fi

running=0
for name in "${names[@]}"; do
    (
        git -C "$ROOT/$name" pull --ff-only >"$tmpdir/$name.log" 2>&1
        echo $? >"$tmpdir/$name.status"
    ) &
    running=$((running + 1))
    if (( running >= JOBS )); then
        wait -n
        running=$((running - 1))
    fi
done

while (( running > 0 )); do
    wait -n
    running=$((running - 1))
done

status=0
for name in "${names[@]}"; do
    if [[ "$(<"$tmpdir/$name.status")" == "0" ]]; then
        echo "== $name: OK =="
    else
        echo "== $name: FAILED =="
        status=1
    fi
    cat "$tmpdir/$name.log"
done

exit "$status"
