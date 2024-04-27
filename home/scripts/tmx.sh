#!/usr/bin/env bash

OPTIONS=$1
PERSONAL=~/personal/
WORK=~/work/

# switch to session if already in a tmux session
# else attach to it
switch_or_attach(){
    if [ -n "$TMUX" ]; then
        tmux switch-client -t $1
    else
        tmux attach-session -t $1
    fi
}



if [ "$OPTIONS" == "d" ]; then
    tmux detach-client

elif [ "$OPTIONS" == "p" ]; then
    SESSION_NAME=`ls $PERSONAL | fzf`
    cd $PERSONAL$SESSION_NAME

    if [[ -z "$SESSION_NAME" ]]; then
        SESSION_NAME="personal"
    fi

    if [[ $SESSION_NAME == *"."* ]]; then
        SESH=$(echo "$SESSION_NAME" | tr '.' '_')
        echo "$SESH"
        tmux new-session -d -s "$SESH"
        switch_or_attach "$SESH"
    else
        tmux new-session -d -s "$SESSION_NAME"
        switch_or_attach "$SESSION_NAME"
    fi

elif [ "$OPTIONS" == "w" ]; then
    SESSION_NAME=`ls $WORK | fzf`
    cd $WORK$SESSION_NAME

    if [[ -z "$SESSION_NAME" ]]; then
        SESSION_NAME="work"
    fi

    if [[ $SESSION_NAME == *"."* ]]; then
        SESH=$(echo "$SESSION_NAME" | tr '.' '_')
        echo "$SESH"
        tmux new-session -d -s "$SESH"
        switch_or_attach "$SESH"
    else
        tmux new-session -d -s "$SESSION_NAME"
        switch_or_attach "$SESSION_NAME"
    fi

elif [ "$OPTIONS" == "a" ]; then
    # list active sessions in bg; get value before the colon pipe to fzf
    ATTACH_TO=`tmux ls | cut -d':' -f1 | fzf`
    if [ "$ATTACH_TO" != "" ]; then
        tmux attach-session -t "$ATTACH_TO"
    else
        echo "[ERROR]: NO SESSION TO ATTACH TO"
    fi
else
    echo "Usage:
    tmx [p|w|a|d]"
fi
