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
cp -rv ~/.fonts $HOME_DIR
cp -rv ~/.local/bin "$HOME_DIR/.local/"
echo "COPIED .P/A/B/G/T TO $HOME_DIR"

cp -rv ~/.config/alacritty $CONFIG_DIR
cp -rv ~/.config/nvim $CONFIG_DIR
cp -rv ~/.config/nvim_packer $CONFIG_DIR
cp -rv ~/.config/Code/User/settings.json $CONFIG_DIR/Code/User/settings.json
cp -v ~/.config/starship.toml $CONFIG_DIR

cp -rv ~/scripts $HOME_DIR

cd "$ROOT_DIR" || exit
ansible-vault encrypt ./keys/* $STASH_DIR/db/* $STASH_DIR/wakatime/*
