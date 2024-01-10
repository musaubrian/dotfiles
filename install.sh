#!/usr/bin/env bash

cp -vr ./scripts/ ~/scripts/
cp -vr ./alacritty/ ~/.config/
cp -v ./home/starship.toml ~/.config/
cp -v ./home/tmux.conf ~/.tmux.conf
cp -v ./home/gitconfig ~/.gtconfig
cp -v ./home/aliases ~/.aliases
cp -v ./home/profile ~/.profile
cp -v ./home/spotify_adblock.desktop ~/.local/share/applications
cp -rv ./fonts/* ~/.local/share/fonts


#VS Code
mkdir -p ~/.config/Code/User
cp -v ./home/settings.json ~/.config/Code/User

read -p "Packer(1) or Lazy(2)? " opt

if [[ $opt == 1 ]]; then
    #Check if nvim exist first
    if [ -d "~/.config/nvim" ]; then
        mv ~/.config/nvim ~/config/nvim_bkp
    fi
    cd ./neovim/nvim_packer || exit
    ./install_packer.sh
elif [[ $opt == 2 ]]; then
    #Check if nvim exist first
    if [ -d "~/.config/nvim" ]; then
        mv ~/.config/nvim ~/config/nvim_bkp
    fi
    cp -vr ./neovim/nvim_lazy/nvim ~/.config/nvim
else
    echo "Pick either 1 or 2"
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
# oh-my-zsh overrides the original .zshrc so copy it after setting it up
cp -v ./home/zshrc ~/.zshrc


# Install Fuzzy Finder (fzf)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# install ripgrep
sudo apt-get install ripgrep

#decrypt ssh keys first
ansible-vault decrypt ./keys/*

cp -r ./keys/* ~/.ssh/ -v

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

# download Iosevka font
# curl -s https://github.com/be5invis/Iosevka/releases/download/v27.3.5/ttf-iosevka-term-27.3.5.zip

chsh -s $(which zsh)
source ~/.zshrc
