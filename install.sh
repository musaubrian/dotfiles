#!/usr/bin/env bash

cp -v ./tmux.conf ~/.tmux.conf
cp -v -r ./scripts/ ~/scripts/
cp -v -r ./alacritty/ ~/.config/
cp -v ./starship.toml ~/.config/
cp -v ./.gitconfig ~/
cp -v ./.aliases ~/
cp -v ./.zshrc ~/

#VS Code
mkdir -p ~/.config/Code/User
cp -v ./settings.json ~/.config/Code/User

read -p "Packer(1) or Lazy(2)? " opt

if [[ $opt == 1 ]]; then
    cd nvim_packer
    ./install_packer.sh
    exit
elif [[ $opt == 2 ]]; then
    cp -vr nvim ~/.config
    exit
else
    echo "Pick either 1 or 2"
    exit
fi
# For tinygo
mkdir -p ~/.db
# If for some reason there is no .ssh directory
mkdir -p ~/.ssh

# install ansible
sudo apt install ansible
# load aliases in .bashrc
echo 'if [ -f ~/.aliases ]; then
    . ~/.aliases
fi'>> ~/.bashrc

# Install starship prompt
curl -sS https://starship.rs/install.sh | sh
# setup bash to use starship
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# oh-my-zsh and zsh
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# fish-like suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


# Install Fuzzy Finder (fzf)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# This could possibly be better, but it works just fine
# setup keys
ansible-vault decrypt ./start/db/* ./start/keys/* ./start/wakatime/*

cp ./start/db/* ~/.db/ -v
cp ./start/wakatime/wakatime.cfg ~/.wakatime.cfg -v
cp -r ./start/keys/* ~/.ssh/ -v

# Re-enrypt everything
ansible-vault encrypt ./start/db/* ./start/keys/* ./start/wakatime/*

# install neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage

./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version
# Optional: exposing nvim globally.
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

source ~/.zshrc
# source packer so that I can just run :PackerSync
# nvim +:so ~/.config/nvim/lua/ernest/packer.lua
