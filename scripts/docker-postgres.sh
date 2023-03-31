#!/usr/bin/env bash

if [ "$1" == "" ]; then
    if [ "$2" == "" ]; then
        echo "usage $0 some-name secretpassword"
        echo ""
    fi
else
    docker run --name $1 -e POSTGRES_PASSWORD=$2 -p 5432:5432 -d postgres
fi
