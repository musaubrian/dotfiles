#!/usr/bin/env bash

ATTACH_TO=`tmux ls | cut -d':' -f1 | fzf --height 60% \
    --layout reverse \
    --prompt '∷ ' \
    --pointer ▶ `
if [ "$ATTACH_TO" != "" ]; then
    tmux attach-session -t "$ATTACH_TO"
else
    echo "[ERROR]: NO SESSION TO ATTACH TO"
fi
