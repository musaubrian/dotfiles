#!/usr/bin/env bash


ROOT_DIR="$HOME/personal/dotfiles"
HOME_DIR="$ROOT_DIR/home/"
KEYS_DIR="$ROOT_DIR/keys"
STASH_DIR="$ROOT_DIR/stash"
TO_DB="$STASH_DIR/db"
WAKA_KEY="$STASH_DIR/wakatime/wakatime.cfg"

cp ~/.ssh/* $KEYS_DIR
echo "COPIED TO $KEYS_DIR"

cp ~/.db/tinygo.db $TO_DB
cp ~/.wakatime.cfg $WAKA_KEY
echo "COPIED TO $STASH_DIR"

cp ~/.zshrc $HOME_DIR/zshrc
cp ~/.profile $HOME_DIR/profile
cp ~/.aliases $HOME_DIR/aliases
eco "COPIED .Z/P/A TO $HOME_DIR"

cp -rv ~/.config/alacritty $ROOT_DIR
cp -rv ~/.fonts/* "$ROOT_DIR/fonts"

rm -r $ROOT_DIR/scripts
cp -r ~/scripts $ROOT_DIR

read -p "To packer(1) or Lazy(2) dir: " OPTS
if [[ $OPTS == 1 ]]; then
    rm -r "$ROOT_DIR/neovim/nvim_packer/nvim/"
    cp -rv ~/.config/nvim ~/personal/dotfiles/neovim/nvim_packer/
elif [[ $OPTS == 2 ]]; then
    rm -r "$ROOT_DIR/neovim/nvim_lazy"
    cp -rv ~/.config/nvim/ ~/personal/dotfiles/neovim/nvim_lazy/
fi

cd "$ROOT_DIR" || exit
ansible-vault encrypt ./keys/* $STASH_DIR/db/* $STASH_DIR/wakatime/*
