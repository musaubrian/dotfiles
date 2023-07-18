#!/usr/bin/env bash

ROOT_DIR="$HOME/personal/dotfiles/start"
TO_DB="$ROOT_DIR/db"
TO_KEYS="$ROOT_DIR/keys"
WAKA_KEY="$ROOT_DIR/wakatime/wakatime.cfg"

cp ~/.db/tinygo.db $TO_DB 
cp ~/.ssh/* $TO_KEYS
cp ~/.wakatime.cfg $WAKA_KEY

echo "copy done"
cd "$ROOT_DIR" || exit
ansible-vault encrypt ./db/* ./keys/* ./wakatime/*
