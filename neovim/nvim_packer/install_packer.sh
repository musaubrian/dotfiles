#!/usr/bin/env bash

# Install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Backup old config if available 
mv ~/.config/nvim ~/.config/nvim_bkp

cp -rv ./nvim ~/.config/
