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

# switch to session if already in a tmux session
# else attach to it
switch_or_attach(){
    if [ -n "$TMUX" ]; then
        tmux switch-client -t $1
    else
        tmux attach-session -t $1
    fi
}

if [[ -n "$SELECTED_DIR" ]]; then
    builtin cd "$HOME/$SELECTED_DIR"

    SESSION=$(basename "$SELECTED_DIR")
    tmux new-session -d -s "$SESSION"
    switch_or_attach "$SESSION"
else
    echo "[ERROR]: No directory selected"
fi
