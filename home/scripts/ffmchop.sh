#!/usr/bin/env bash

# Check if correct number of arguments is passed
if [ $# -ne 3 ]; then
    echo "Usage: $0 <source_video> <segment_duration> <total_duration>"
    echo "Example: $0 input.mp4 00:01:00 00:20:00"
    exit 1
fi

# Arguments
SRC_VIDEO=$1
SEGMENT_DURATION=$2
UP_TO=$3

# Create output directory
OUTPUT_DIR="${SRC_VIDEO%.*}_output"
mkdir -p "$OUTPUT_DIR"

# Output pattern (in the new output directory)
OUTPUT_PATTERN="$OUTPUT_DIR/segment_%03d.mp4"

# Get the number of CPU cores
CPU_CORES=$(nproc)

# Get video duration
VIDEO_DURATION=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$SRC_VIDEO")

# Use the shorter of UP_TO and VIDEO_DURATION
if (( $(echo "$UP_TO > $VIDEO_DURATION" | bc -l) )); then
    DURATION=$VIDEO_DURATION
else
    DURATION=$UP_TO
fi

# 9:16 aspect ratio conversion and segmenting with CPU optimizations
ffmpeg -i "$SRC_VIDEO" \
    -vf "scale=iw*min(608/iw\,1080/ih):ih*min(608/iw\,1080/ih), pad=608:1080:(608-iw*min(608/iw\,1080/ih))/2:(1080-ih*min(608/iw\,1080/ih))/2" \
    -c:v libx264 -preset medium -crf 23 \
    -c:a aac -b:a 128k \
    -threads $CPU_CORES \
    -segment_time "$SEGMENT_DURATION" -f segment -reset_timestamps 1 \
    -t "$DURATION" \
    "$OUTPUT_PATTERN"

# Check if FFmpeg command was successful
if [ $? -eq 0 ]; then
    echo "Video has been successfully processed."
    echo "Output segments are in the directory: $OUTPUT_DIR"
    echo "Total duration processed: $DURATION seconds"
else
    echo "An error occurred during video processing."
    exit 1
fi
