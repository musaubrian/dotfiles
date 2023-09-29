#!/usr/bin/env bash

cd ~/personal/notes
session="notes"
links="links"

if tmux has-session -t $session 2>/dev/null; then
    if [ -n "$TMUX" ]; then
        tmux switch-client -t $session
    else
        tmux attach-session -t $session
    fi
else
    tmux new-session -d -s $session

    if [[ "$#" == 0 ]]; then
        tmux send-keys -t $session "nvim ." C-m
    elif [[ "$links" == *"$1"* ]]; then
        LAST_LINE=`wc -l links.md | cut -d' ' -f1`
        tmux send-keys -t $session "nvim links.md +$LAST_LINE" C-m
    fi
    if [ -n "$TMUX" ]; then
        tmux switch-client -t $session
    else
        tmux attach-session -t $session
    fi
fi

