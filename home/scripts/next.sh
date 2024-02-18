#!/usr/bin/env bash
#
PERSONAL_OR_WORK=$1

USAGE="Usage:
    next [p/w]"

if [ "$PERSONAL_OR_WORK" == "p" ]; then
    cd ~/personal && `npx create-next-app@latest`
elif [ "$PERSONAL_OR_WORK" == "w" ]; then
    cd ~/personal && `npx create-next-app@latest`
else
    echo "$USAGE"
fi
