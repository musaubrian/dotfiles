#!/usr/bin/env bash

cp ./tmux.conf ~/.tmux.conf -v
cp -r ./scripts/ ~/scripts/ -v
cp -r ./alacritty/ ~/.config/ -v
cp ./starship.toml ~/.config/ -v


git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Install starship prompt
curl -sS https://starship.rs/install.sh | sh
# setup bash to use starship
echo 'eval "$(starship init bash)"' > ~/.bashrc

# Install Neovim
dnf copr enable agriffis/neovim-nightly
dnf install -y neovim python3-neovim

# Install Fuzzy Finder (fzf)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
