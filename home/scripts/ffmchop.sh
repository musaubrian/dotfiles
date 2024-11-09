#!/usr/bin/env bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 <source_video> [segment_duration] [total_duration]"
    echo "Example with segments: $0 input.mp4 00:01:00 00:20:00"
    echo "Example without segments: $0 input.mp4"
    exit 1
fi

# Arguments
SRC_VIDEO=$1
SEGMENT_DURATION=$2
UP_TO=$3

CPU_CORES=$(nproc)

if [ -n "$SEGMENT_DURATION" ]; then
    if [ -z "$UP_TO" ]; then
        echo "Error: When using segmentation, both segment duration and total duration must be provided"
        exit 1
    fi

    OUTPUT_DIR="${SRC_VIDEO%.*}_output"
    mkdir -p "$OUTPUT_DIR"
    # Get video duration
    VIDEO_DURATION=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$SRC_VIDEO")

    # Use the shorter of UP_TO and VIDEO_DURATION
    if (( $(echo "$UP_TO > $VIDEO_DURATION" | bc -l) )); then
        DURATION=$VIDEO_DURATION
    else
        DURATION=$UP_TO
    fi

    # Output pattern for segments
    OUTPUT_PATTERN="$OUTPUT_DIR/segment_%03d.mp4"

    ffmpeg -i "$SRC_VIDEO" \
        -vf "scale=iw*min(608/iw\,1080/ih):ih*min(608/iw\,1080/ih), pad=608:1080:(608-iw*min(608/iw\,1080/ih))/2:(1080-ih*min(608/iw\,1080/ih))/2" \
        -c:v libx264 -preset medium -crf 23 \
        -c:a aac -b:a 128k \
        -threads "$CPU_CORES" \
        -segment_time "$SEGMENT_DURATION" -f segment -reset_timestamps 1 \
        -t "$DURATION" \
        "$OUTPUT_PATTERN"

    echo "Output is in the directory: $OUTPUT_DIR"
    if [ -n "$SEGMENT_DURATION" ]; then
        echo "Total duration processed: $DURATION seconds"
    fi

else
    # Just perform aspect ratio conversion without segmentation
    OUTPUT_FILE="${SRC_VIDEO%.*}_converted.mp4"

    ffmpeg -i "$SRC_VIDEO" \
        -vf "scale=iw*min(608/iw\,1080/ih):ih*min(608/iw\,1080/ih), pad=608:1080:(608-iw*min(608/iw\,1080/ih))/2:(1080-ih*min(608/iw\,1080/ih))/2" \
        -c:v libx264 -preset medium -crf 23 \
        -c:a aac -b:a 128k \
        -threads "$CPU_CORES" \
        "$OUTPUT_FILE"

    echo "Converted to $OUTPUT_FILE"
fi

# Check if FFmpeg command was successful
if [ $? -eq 0 ]; then
    echo "Video has been successfully processed."
else
    echo "An error occurred during video processing."
    exit 1
fi
