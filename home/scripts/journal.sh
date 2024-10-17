#!/usr/bin/env bash



today=$(date '+%Y-%m-%d')

TODAY_NOTE="$HOME/personal/notes/trading/journal/$today"

touch $TODAY_NOTE

nvim $TODAY_NOTE
