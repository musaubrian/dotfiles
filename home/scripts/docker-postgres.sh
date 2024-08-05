#!/usr/bin/env bash

if [ "$1" == "" ] || [ "$2" == "" ] || [ "$3" == "" ] || [ "$4" == "" ]; then
    echo "Usage: $0 container-name postgres-user postgres-password postgres-db"
    echo ""
else
    docker run --name $1 -e POSTGRES_USER=$2 -e POSTGRES_PASSWORD=$3 -e POSTGRES_DB=$4 -p 5432:5432 -d postgres
    echo "Connection URL:\n postgres://$2:$3@localhost:5432/$4"
fi
