#!/usr/bin/env bash

ROOT_DIR="$HOME/personal/dotfiles"
KEYS_DIR="$ROOT_DIR/keys"
STASH_DIR="$ROOT_DIR/stash"
TO_DB="$STASH_DIR/db"
WAKA_KEY="$STASH_DIR/wakatime/wakatime.cfg"
NIX_CONFIG="$ROOT_DIR/home/configuration.nix"


cp ~/.ssh/* $KEYS_DIR
echo "COPIED TO $KEYS_DIR"

cp ~/.db/tinygo.db $TO_DB
cp ~/.wakatime.cfg $WAKA_KEY
echo "COPIED TO $STASH_DIR"

pushd "$ROOT_DIR"

ansible-vault encrypt ./keys/* $STASH_DIR/db/* $STASH_DIR/wakatime/*

alejandra "$NIX_CONFIG" &>/dev/null

echo "Rebuilding NixOS..."
sudo nixos-rebuild switch &>/tmp/nixos-switch.log || \
    (cat /tmp/nixos-switch.log | grep error && false)

gen=$(nixos-rebuild list-generations | grep current | awk '{print "build(" $1 ") NixOS vers: " $5 " Kernel: " $6}')

git add .
git commit -m "$gen"
git push origin main

pushd "$ROOT_DIR/stash"
git add .
git commit -m "follow $gen"
git push origin main
popd

popd
