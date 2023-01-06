#!/usr/bin/env bash
#cheat sheet from the command line

langs=`echo "golang python typescript javascript" | tr ' ' '\n'`

selected=`printf "$langs" | fzf`
echo "Selected $selected"

read -p "Question: " query

tmux neww curl cht.sh/$selected/`echo $query | tr ' ' '+'` & while [[ : ]]; do sleep 3; done
