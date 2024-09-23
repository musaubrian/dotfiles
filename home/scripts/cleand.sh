#!/usr/bin/env bash

image_ext=("jpg" "jpeg" "png" "gif" "svg")
music_ext=("mp3" "m4a" "flac")
video_ext=("mp4" "avi" "mkv" "wmv")
document_ext=("pdf" "doc" "docx" "txt" "PDF" "csv" "CSV" "pptx" "xlsx")
zips=("zip" "tar" "gzip" "gz")
images=("iso")

cd $downloads || exit

for file in ~/.var/app/org.telegram.desktop/data/TelegramDesktop/tdata/temp_data/*; do

    ext="${file##*.}"
    if [[ " ${video_ext[@]} " =~ " ${ext} " ]]; then
        mv "$file" ~/Downloads/
    elif [[ " ${document_ext[@]} " =~ " ${ext} " ]]; then
        mv "$file" ~/Documents/mang
    elif [[ " ${music_ext[@]} " =~ " ${ext} " ]]; then
        mv "$file" ~/Downloads/
    fi

done

for file in ~/Downloads/Telegram\ Desktop/*;do

    ext="${file##*.}"
    if [[ " ${video_ext[@]} " =~ " ${ext} " ]]; then
        mv "$file" ~/Downloads/
    elif [[ " ${document_ext[@]} " =~ " ${ext} " ]]; then
        mv "$file" ~/Documents/mang
    elif [[ " ${music_ext[@]} " =~ " ${ext} " ]]; then
        mv "$file" ~/Downloads/
    fi

done

# Loop through all files in the Downloads directory
for file in ~/Downloads/*; do
    # Get the file extension
    ext="${file##*.}"
    # Check if it's an image file
    if [[ " ${image_ext[@]} " =~ " ${ext} " ]]; then
        mv "$file" ~/Pictures
        printf "moved [$file] -> [~/Pictures/]\n"
        # Check if it's a video file
    elif [[ " ${video_ext[@]} " =~ " ${ext} " ]]; then
        mv "$file" ~/Videos
        printf "moved [$file] -> [~/Videos/]\n"
        # Check if it's a document file
    elif [[ " ${document_ext[@]} " =~ " ${ext} " ]]; then
        mv "$file" ~/Documents
        printf "moved [$file] -> [~/Documents/]\n"
    elif [[ " ${zips[@]}" =~ " ${ext} " ]]; then
        mv "$file" ~/Downloads/zip/
        printf "moved $file -> [~/Downloads/zip/]\n"
    elif [[ " ${images[@]} " =~ " ${ext} " ]]; then
        mv "$file" ~/Downloads/images/
        printf "moved $file -> [~/Downloads/images/]\n"
    elif [[ " ${music_ext[@]} " =~ " ${ext} " ]]; then
        mv "$file" ~/Music/
        printf "moved $file -> [~/Music/]\n"
    fi
done
