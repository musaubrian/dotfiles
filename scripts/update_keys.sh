#!/usr/bin/env bash

ROOT_DIR="$HOME/personal/dotfiles/start"
TO_DB="$ROOT_DIR/db"
TO_KEYS="$ROOT_DIR/keys"

cp ~/.db/tinygo.db $TO_DB 
cp ~/.ssh/* $TO_KEYS

echo "copy done"
cd "$ROOT_DIR" || exit
ansible-vault encrypt ./db/* ./keys/*
