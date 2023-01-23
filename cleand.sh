#!/usr/bin/env bash
# moves files to different dirs

downloads="/home/ernest/Downloads/"
image_ext=("jpg" "jpeg" "png" "gif" "svg")
video_ext=("mp4" "avi" "mkv" "wmv")
document_ext=("pdf" "doc" "docx" "txt" "PDF" "csv" "CSV" "pptx")

cd $downloads || exit

# Loop through all files in the Downloads directory
for file in ~/Downloads/*; do
    # Get the file extension
    ext="${file##*.}"
    # Check if it's an image file
    if [[ " ${image_ext[@]} " =~ " ${ext} " ]]; then
        mv "$file" ~/Pictures
        printf "moved [$file] -> [~/Pictures/]\n\n"
        # Check if it's a video file
    elif [[ " ${video_ext[@]} " =~ " ${ext} " ]]; then
        mv "$file" ~/Videos
        printf "moved [$file] -> [~/Videos/]\n\n"
        # Check if it's a document file
    elif [[ " ${document_ext[@]} " =~ " ${ext} " ]]; then
        mv "$file" ~/Documents 
        print "moved [$file] -> [~/Documents/]\n\n"
    else
        printf "Nothing to move\n"
    fi
done 
