#!/usr/bin/env bash

ATTACH_TO=`tmux ls | cut -d':' -f1 | fzf --height 60% \
    --layout reverse \
    --prompt '∷ ' \
    --pointer ▶ `

switch_or_attach(){
    if [ -n "$TMUX" ]; then
        tmux switch-client -t $1
    else
        tmux attach-session -t $1
    fi
}

if [ "$ATTACH_TO" != "" ]; then
    switch_or_attach "$ATTACH_TO"
    # tmux attach-session -t "$ATTACH_TO"
else
    echo "[ERROR]: NO SESSION TO ATTACH TO"
fi
