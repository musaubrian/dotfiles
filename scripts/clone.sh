#!/usr/bin/env bash
#

PERSONAL_OR_WORK="$1"
URL="$2"
GIT_URL="git@github.com:"$URL

if [ "$PERSONAL_OR_WORK" == "" ]; then
    echo "Destination not set"
    echo "usage:
            clone [p/w] username/repo"
elif [ "$PERSONAL_OR_WORK" == "p" ]; then
    echo "Switched to personal"
    echo "$GIT_URL"
    cd ~/personal/ && `git clone $GIT_URL`
elif [ "$PERSONAL_OR_WORK" == "w"]; then
    echo "Switched to work"
    cd ~/work// && `git clone $GIT_URL`
fi
