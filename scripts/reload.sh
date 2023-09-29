#!/usr/bin/env bash

if [ -n "$BASH_VERSION" ]; then
    source ~/.bashrc
    clear
elif [ -n "$ZSH_VERSION" ]; then
    source ~/.zshrc
    clear
else
  echo "You are not running Bash or Zsh"
fi
