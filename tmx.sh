#!/usr/bin/env bash

CLOSE=$1
BASE_PATH=~/Desktop/

if [ "$CLOSE" == "dd" ]; then
    tmux detach-client
else
    SESSION_NAME=`ls ~/Desktop/ | fzf`
    cd $BASE_PATH$SESSION_NAME
    #Launch tmux session
    tmux new-session -d -s "$SESSION_NAME"
    tmux send-keys "clear" C-m
fi

tmux attach-session -t "$SESSION_NAME"
