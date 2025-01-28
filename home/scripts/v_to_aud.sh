#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    echo "Error: Please provide an input file"
    echo "Usage: $0 /path/to/file/to/convert [output/path]"
    exit 1
fi

source=$1
out=$2

# Set default output path if not provided, replacing .mp4 with .mp3
if [ -z "$out" ]; then
    out="${source%.*}.mp3"
fi

# Convert the file to MP3
ffmpeg -i "$source" -vn -acodec libmp3lame "$out"
