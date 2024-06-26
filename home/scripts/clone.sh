#!/usr/bin/env bash

PERSONAL_OR_WORK="$1"
GIT_HUB_OR_LAB="$2"
URL="$3"
CLONE_AS="$4"
DEPTH="$5"
USAGE_INSTRUCTION="Usage:
clone [p/w] [l(gitlab)/h(github)] username/repo clone_as"

if [ "$GIT_HUB_OR_LAB" == "l" ]  || [ "$GIT_HUB_OR_LAB" == "lab" ]; then
    GIT_URL="git@gitlab.com:$URL $CLONE_AS $DEPTH"
elif [ "$GIT_HUB_OR_LAB" == "h" ]  || [ "$GIT_HUB_OR_LAB" == "hub" ]; then
    GIT_URL="git@github.com:$URL $CLONE_AS $DEPTH"
else
    echo "$USAGE_INSTRUCTION"
fi



if [ "$PERSONAL_OR_WORK" == "p" ]; then
    echo "Switched to personal"
    cd ~/personal/ && `git clone $GIT_URL`
elif [ "$PERSONAL_OR_WORK" == "w" ]; then
    echo "Switched to work"
    cd ~/work/ && `git clone $GIT_URL`
fi
