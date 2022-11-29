#!/usr/bin/env bash

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

cp -r ./nvim ~/.config/nvim
cp -r ./coc ~/.config/coc

cd ~/.config/coc/extensions || exit
npm install
