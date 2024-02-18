#!/usr/bin/env bash

IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0 --height=80% --layout=reverse --border=rounded --preview 'cat {}'))
[[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
