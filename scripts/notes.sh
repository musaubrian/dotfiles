#!/usr/bin/env bash

cd ~/personal/notes
session="notes"

if tmux has-session -t $session 2>/dev/null; then
    if [ -n "$TMUX" ]; then
        tmux switch-client -t $session
    else
        tmux attach-session -t $session
    fi
else
    tmux new-session -d -s $session
    tmux send-keys -t $session "nvim ." C-m
    if [ -n "$TMUX" ]; then
        tmux switch-client -t $session
    else
        tmux attach-session -t $session
    fi
fi

