#!/usr/bin/env bash

PERSONAL=~/personal/
WORK=~/work/
THIRDPARTY=~/thirdparty/

PERSONAL_DIRS=$(find "$PERSONAL" -maxdepth 1 -type d | sed "s|^$HOME/||")
WORK_DIRS=$(find "$WORK" -maxdepth 1 -type d | sed "s|^$HOME/||")
THIRDPARTY_DIRS=$(find "$THIRDPARTY" -maxdepth 1 -type d | sed "s|^$HOME/||")

ALL_DIRS=$(echo -e "${PERSONAL_DIRS}\n${WORK_DIRS}\n$THIRDPARTY_DIRS")

SELECTED_DIR=$(echo "$ALL_DIRS" | fzf --height 60% \
    --layout reverse \
    --prompt '∷ ' \
    --pointer ▶)

if [[ -n "$SELECTED_DIR" ]]; then
    builtin cd "$HOME/$SELECTED_DIR"
else
    echo "[ERROR]: No directory selected"
fi
