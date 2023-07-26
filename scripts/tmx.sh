#!/usr/bin/env bash

OPTIONS=$1
PERSONAL=~/personal/
WORK=~/work/

if [ "$OPTIONS" == "d" ]; then
    tmux detach-client

elif [ "$OPTIONS" == "p" ]; then
    SESSION_NAME=`ls $PERSONAL | fzf`
    cd $PERSONAL$SESSION_NAME

    if [[ $SESSION_NAME == *"."* ]]; then
        SESH=$(echo "$SESSION_NAME" | tr '.' '_')
        tmux new-session -d -s "$SESH"
        tmux attach-session -t "$SESH"
    else
        tmux new-session -d -s "$SESSION_NAME"
        tmux attach-session -t "$SESSION_NAME"
    fi

elif [ "$OPTIONS" == "w" ]; then
    SESSION_NAME=`ls $WORK | fzf`
    cd $WORK$SESSION_NAME

    if [[ $SESSION_NAME == *"."* ]]; then
        SESH=$(echo "$SESSION_NAME" | tr '.' '_')
        echo "$SESH"
        tmux new-session -d -s "$SESH"
        tmux attach-session -t "$SESH"
    else
        tmux new-session -d -s "$SESSION_NAME"
        tmux attach-session -t "$SESSION_NAME"
    fi

elif [ "$OPTIONS" == "a" ]; then
    # list active sessions in bg; get value before the colon pipe to fzf
    ATTACH_TO=`tmux ls | cut -d':' -f1 | fzf`
    if [ "$ATTACH_TO" != "" ]; then
        tmux attach-session -t "$ATTACH_TO"
    else
        echo "NO session to attach to"
    fi
else
    echo "Usage:
    tmx [p|w|a|d]"
fi
