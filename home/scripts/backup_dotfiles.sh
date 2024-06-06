#!/usr/bin/env bash

ROOT_DIR="$HOME/personal/dotfiles"
HOME_DIR="$ROOT_DIR/home/"
KEYS_DIR="$ROOT_DIR/keys"
CONFIG_DIR="$HOME_DIR/.config"
STASH_DIR="$ROOT_DIR/stash"
TO_DB="$STASH_DIR/db"
WAKA_KEY="$STASH_DIR/wakatime/wakatime.cfg"



cp ~/.ssh/* $KEYS_DIR
echo "COPIED TO $KEYS_DIR"

cp ~/.db/tinygo.db $TO_DB
cp ~/.wakatime.cfg $WAKA_KEY
echo "COPIED TO $STASH_DIR"

cp ~/.profile $HOME_DIR
cp ~/.aliases $HOME_DIR
cp ~/.bashrc $HOME_DIR
cp ~/.bash_completions $HOME_DIR
cp ~/.gitconfig $HOME_DIR
cp ~/.tmux.conf $HOME_DIR
cp -r ~/.fonts $HOME_DIR
cp -r ~/.local/bin "$HOME_DIR/.local/"
echo "COPIED .<files> TO $HOME_DIR"

cp -r ~/.config/alacritty $CONFIG_DIR
cp -r ~/.config/nvim $CONFIG_DIR
cp -r ~/.config/nvim_packer $CONFIG_DIR
cp -r ~/.config/Code/User/settings.json $CONFIG_DIR/Code/User/settings.json
cp -r ~/.config/Code/User/keybindings.json $CONFIG_DIR/Code/User/keybindings.json
cp -v ~/.config/starship.toml $CONFIG_DIR

echo "COPIED TO $CONFIG_DIR"

cp -r ~/scripts $HOME_DIR
echo "COPIED scripts/"

cd "$ROOT_DIR" || exit
ansible-vault encrypt ./keys/* $STASH_DIR/db/* $STASH_DIR/wakatime/*
