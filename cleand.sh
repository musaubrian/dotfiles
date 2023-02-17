#!/usr/bin/env bash
# moves files to different dirs

image_ext=("jpg" "jpeg" "png" "gif" "svg")
video_ext=("mp4" "avi" "mkv" "wmv")
document_ext=("pdf" "doc" "docx" "txt" "PDF" "csv" "CSV" "pptx" "xlsx")
zips=("zip" "tar" "gzip" "gz")
images=("iso")

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
        printf "moved [$file] -> [~/Documents/]\n\n"
    elif [[ " ${zips[@]}" =~ " ${ext} " ]]; then
        mv "$file" ~/Downloads/zip/
        printf "moved $file -> [~/Downloads/zip/]"
    elif [[ " ${images[@]} " =~ " ${ext} " ]]; then
        mv "$file" ~/Downloads/images/
        printf "moved $file -> [~/Downloads/images/]"
    fi
done 
