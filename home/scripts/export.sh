#!/usr/bin/env bash

# File to read
file="$1"

while read -r line; do
    # Skip comments and empty lines
    [[ "$line" == \#* || -z "$line" ]] && continue
    export "$line"
    echo "Exported $line"
done < "$1"
