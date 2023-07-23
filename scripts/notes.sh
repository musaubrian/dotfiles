#!/usr/bin/env bash

cd ~/personal/notes
tmux new-session -d -s "notes"
tmux -c "nvim ."
tmux attach-session -t "notes"
