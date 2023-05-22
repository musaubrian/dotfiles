#!/usr/bin/env bash

cp ./tmux.conf ~/.tmux.conf -v
cp -r ./scripts/ ~/scripts/ -v
cp -r ./alacritty/ ~/.config/ -v
cp ./starship.toml ~/.config/ -v
cp -r nvim ~/.config/
cp ./.gitconfig ~/ -v

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# install ansible
python3 -m pip install --user ansible

# Install starship prompt
curl -sS https://starship.rs/install.sh | sh
# setup bash to use starship
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# Install Fuzzy Finder (fzf)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Setup keys
ansible-playbook ./start/playbook.yaml --ask-vault-password
