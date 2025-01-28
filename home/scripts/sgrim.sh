#!/usr/bin/env bash

SAVE_DIR="$HOME/Pictures/screenshots"
FILENAME="screenshot_$(date +%Y%m%d_%H%M%S).png"
FILEPATH="$SAVE_DIR/$FILENAME"

mkdir -p "$SAVE_DIR"

if [ "$#" -eq 0 ]; then
    #default to copy to clipboard
    grim -g "$(slurp -d)" - | wl-copy
    if [ $? -eq 0 ]; then
        notify-send -a "grim" -u low -i "$HOME/personal/dotfiles/wall.jpg" "Screenshot Saved to clipboard"
    fi
else
    grim -g "$(slurp -d)" "$FILEPATH"
    if [ $? -eq 0 ]; then
        notify-send -a "grim" -u low -i "$FILEPATH" "Screenshot saved" "Screenshot saved at $SAVE_DIR"
    fi
fi


