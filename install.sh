#!/usr/bin/env bash

install_packages() {
    sudo apt update -y && sudo apt upgrade -y
    sudo apt install curl wget tmux ansible i3 kitty ripgrep \
        python3-launchpadlib python3-venv vlc pavucontrol brightnessctl -y
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

    sudo chmod +s $(which brightnessctl)
}

setup_shell_environment() {
    # echo 'if [ -f ~/.aliases ]; then
    #    . ~/.aliases
    # fi' >> ~/.bashrc

    curl -sS https://starship.rs/install.sh | sh
    # echo 'eval "$(starship init bash)"' >> ~/.bashrc
}

setup_fzf() {
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    if type rg &> /dev/null; then
        export FZF_DEFAULT_COMMAND='rg --files --hidden'
    fi
}

manage_ssh_keys() {
    mkdir -p ~/.ssh
    ansible-vault decrypt ./keys/*
    cp -rv ./keys/* ~/.ssh/
}

manage_stash_repo() {
    mkdir -p ~/.db
    git clone git@github.com:musaubrian/stash
    ansible-vault decrypt ./stash/db/* ./stash/wakatime/*
    cp ./stash/db/* ~/.db/ -v
    cp ./stash/wakatime/wakatime.cfg ~/.wakatime.cfg -v
    ansible-vault encrypt ./stash/db/* ./keys/* ./stash/wakatime/*
}

copy_dotfiles() {
    dirs_to_home=("./home/.fonts" "./home/.local" "./home/scripts" "./home/.aliases")
    files_to_home=("./home/.bash_completions" "./home/.bashrc" "./home/.gitconfig" "./home/.profile" "./home/.tmux.conf" "./home/.zshrc")
    dirs_to_config=("./home/.config/Code" "./home/.config/alacritty" "./home/.config/nvim", "./home/kitty", "./home/.config/i3")
    files_to_config=("./home/.config/starship.toml")

    for dir in "${dirs_to_home[@]}"; do
        cp -rv "$dir" ~/
    done

    for file in "${files_to_home[@]}"; do
        cp -r "$file" ~/
    done

    for dir in "${dirs_to_config[@]}"; do
        cp -rv "$dir" ~/.config/
    done

    for file in "${files_to_config[@]}"; do
        cp -v "$file" ~/.config/
    done
}

setup_trackpad() {
    mkdir -p /etc/X11/xorg.conf.d/
    sudo cp -v ./home/90-touchpad.conf /etc/X11/xorg.conf.d/
}

setup_neovim() {
    curl -sLO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    ./nvim.appimage --appimage-extract
    ./squashfs-root/AppRun --version
    sudo mv squashfs-root /
    sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
}

clean_up() {
    rm -v nvim.appimage*
}

setup_docker() {
    # Add Docker's official GPG key:
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update -y

    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo usermod -aG docker $USER
}


main() {
    install_packages
    setup_shell_environment
    setup_fzf
    manage_ssh_keys
    manage_stash_repo
    copy_dotfiles
    setup_trackpad
    setup_neovim
    setup_docker
    clean_up
}

main
