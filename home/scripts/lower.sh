#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

directory="$1"

if [ ! -d "$directory" ]; then
    echo "Directory does not exist: $directory"
    exit 1
fi

cd "$directory" || exit 1

if [ -z "$(ls -A)" ]; then
    echo "Directory is empty. Exiting."
    exit 0
fi

for file in *; do
    # Convert the file name to lowercase and replace "-" with "_"
    new_name="${file,,}"
    new_name="${new_name//-/_}"

    mv "$file" "$new_name"
done
