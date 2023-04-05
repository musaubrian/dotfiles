#!/usr/bin/env bash

ATTACH_OR_CLOSE=$1
BASE_PATH=~/Desktop/

if [ "$ATTACH_OR_CLOSE" == "dd" ]; then
    tmux detach-client
elif [ "$ATTACH_OR_CLOSE" == "attach" ]; then
    # list active sessions in bg; get value before the colon pipe to fzf
    SESSION=`tmux ls| cut -d':' -f1 | fzf`
    tmux attach-session -t $SESSION
else
    SESSION_NAME=`ls ~/Desktop/ | fzf`
    cd $BASE_PATH$SESSION_NAME
    #Launch tmux session
    tmux new-session -d -s "$SESSION_NAME"
    tmux attach-session -t "$SESSION_NAME"
fi

