#!/usr/bin/env bash
# DEPRECATED: Replaced with f.sh

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

elif [ "$OPTIONS" == "" ]; then
    PERSONAL_DIRS=$(ls $PERSONAL | tr -s "\n" | sed "s/^/personal\//")
    WORK_DIRS=$(ls $WORK | tr -s "\n" | sed "s/^/work\//")

    ALL_DIRS=$(echo -e "${PERSONAL_DIRS}\n${WORK_DIRS}")

    SESSION_NAME=$(echo "$ALL_DIRS"  | fzf)


    if [[ -z "$SESSION_NAME" ]]; then
        SESSION_NAME="general"
    else
        cd "$HOME/$SESSION_NAME"
    fi

    # remove the prefixed personal/work
    SESSION_NAME=$(echo "$SESSION_NAME" | sed "s/personal\///;s/work\///")

    if [[ $SESSION_NAME == *"."* ]]; then
        SESH=$(echo "$SESSION_NAME" | tr '.' '_')
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
    tmx [a|d]"
fi
