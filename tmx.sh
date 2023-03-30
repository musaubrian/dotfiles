#!/usr/bin/env bash

SESSION_NAME=$1
BASE_PATH=~/Desktop/

if [ "$SESSION_NAME" == "dd" ]; then
    tmux detach-client
fi

if [ ! -d $BASE_PATH$1 ]; then
    echo "~/Desktop/$SESSION_NAME does not exist"
    exit 1
fi

cd ~/Desktop/$1

# Launch tmux session
tmux new-session -d -s "$SESSION_NAME"
tmux send-keys "clear" C-m
tmux attach-session -t "$SESSION_NAME"

