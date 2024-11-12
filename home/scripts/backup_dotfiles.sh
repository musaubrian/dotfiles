#!/usr/bin/env bash

ROOT_DIR="$HOME/personal/dotfiles"
KEYS_DIR="$ROOT_DIR/keys"
STASH_DIR="$ROOT_DIR/stash"
TO_DB="$STASH_DIR/db"
WAKA_KEY="$STASH_DIR/wakatime/wakatime.cfg"



cp ~/.ssh/* $KEYS_DIR
echo "COPIED TO $KEYS_DIR"

cp ~/.db/tinygo.db $TO_DB
cp ~/.wakatime.cfg $WAKA_KEY
echo "COPIED TO $STASH_DIR"


cd "$ROOT_DIR" || exit
ansible-vault encrypt ./keys/* $STASH_DIR/db/* $STASH_DIR/wakatime/*
