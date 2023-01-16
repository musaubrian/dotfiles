#!/usr/bin/env bash

mkdir ~/scripts/
cp ./tmux.conf ~/.tmux.conf
cp ./cht.sh ~/scripts/

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
