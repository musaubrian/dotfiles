#!/usr/bin/env bash


cp -r ./nvim ~/.config/nvim
cp -r ./coc ~/.config/coc

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

cd ~/.config/coc/extensions || exit
npm install
