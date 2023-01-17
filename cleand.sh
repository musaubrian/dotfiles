#!/usr/bin/env bash
# moves files to different dirs

downloads="/home/ernest/Downloads/"
image_ext=("jpg" "jpeg" "png" "gif" "svg")
video_ext=("mp4" "avi" "mkv" "wmv")
document_ext=("pdf" "doc" "docx" "txt")

cd $downloads || exit

# Loop through all files in the Downloads directory
for file in ~/Downloads/*; do
    # Get the file extension
    ext="${file##*.}"
    # Check if it's an image file
    if [[ " ${image_ext[@]} " =~ " ${ext} " ]]; then
        mv -v "$file" ~/Pictures
        # Check if it's a video file
    elif [[ " ${video_ext[@]} " =~ " ${ext} " ]]; then
        mv -v "$file" ~/Videos
        # Check if it's a document file
    elif [[ " ${document_ext[@]} " =~ " ${ext} " ]]; then
        mv -v "$file" ~/Documents 
    else
        echo "Nothing to move"
    fi
done 
