#!/bin/bash

timestamp=$(date +%Y-%m-%d_%H-%M-%S)
filename="$HOME/Pictures/Screenshots/screenshot_$timestamp.png"

if [ "$1" = "select" ]; then
    maim -s "$filename"
    xclip -selection clipboard -t image/png -i "$filename"
else
    maim "$filename"
    xclip -selection clipboard -t image/png -i "$filename"
fi

