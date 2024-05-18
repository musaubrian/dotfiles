#!/usr/bin/env bash

cp -rv ./home ~/.home

# For tinygo
mkdir -p ~/.db
# If for some reason there is no .ssh directory
mkdir -p ~/.ssh

# install packages, just to be safe
sudo apt install curl wget tmux ansible alacritty zsh ripgrep python3-launchpadlib python3-venv stow -y

# load aliases in .bashrc
echo 'if [ -f ~/.aliases ]; then
   . ~/.aliases
fi'>> ~/.bashrc

# Install starship prompt
curl -sS https://starship.rs/install.sh | sh
# setup bash to use starship
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# Install Fuzzy Finder (fzf)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install


#decrypt ssh keys first
ansible-vault decrypt ./keys/*

cp -rv ./keys/* ~/.ssh/

git clone git@github.com:musaubrian/stash

ansible-vault decrypt ./stash/db/* ./stash/wakatime/*
cp ./stash/db/* ~/.db/ -v
cp ./stash/wakatime/wakatime.cfg ~/.wakatime.cfg -v

# Re-enrypt everything
ansible-vault encrypt ./stash/db/* ./keys/* ./stash/wakatime/*

# install neovim
curl -sLO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version
# Optional: exposing nvim globally.
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

# make fzf use ripgrep
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
fi
