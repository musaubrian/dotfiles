#!/usr/bin/env bash
#cheat sheet from the command line

langs=`echo "golang python typescript javascript vim" | tr ' ' '\n'`

selected=`printf "$langs" | fzf`
echo "Selected $selected"

read -p "Question: " question
query=`echo $question | tr ' ' '+'`

tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
