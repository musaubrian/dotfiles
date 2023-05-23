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

# This could possibly be better, but it works just fine
# setup keys
ansible-vault decrypt ./start/db/* ./start/keys/*

cp ./start/db/* ~/.db/ -v
cp -r ./start/keys/* ~/.ssh/ -v

# Re-enrypt everything
ansible-vault encrypt ./start/db/* ./start/keys/*




# install neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage

./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version
# Optional: exposing nvim globally.
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
