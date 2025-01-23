#!/usr/bin/env bash

CLONE_DIR="$1"
SOURCE="$2"
URL="$3"
CLONE_AS="$4"
EXTRA="$5"
USAGE_INSTRUCTION="Usage:
    clone [p|w|t] [h|r] [username/repo | full_url_if_not_gh] clone_as <any_other_flags>"

if [ "$SOURCE" == "h" ]; then
    GIT_OPTS="git@github.com:$URL $CLONE_AS $EXTRA"
elif [ "$SOURCE" == "r" ]; then
    GIT_OPTS="$URL $CLONE_AS $EXTRA"
else
    echo "$USAGE_INSTRUCTION"
    exit 1
fi


if [ "$CLONE_DIR" == "p" ]; then
    echo "Switched to personal"
    cd ~/personal/ && `git clone $GIT_OPTS`
elif [ "$CLONE_DIR" == "w" ]; then
    echo "Switched to work"
    cd ~/work/ && `git clone $GIT_OPTS`
elif [ "$CLONE_DIR" == "t" ]; then
    echo "Switched to thirdparty"
    cd ~/thirdparty/ && `git clone $GIT_OPTS`
fi
