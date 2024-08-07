#!/usr/bin/env bash

install_packages() {
    sudo apt install curl wget tmux ansible alacritty zsh ripgrep python3-launchpadlib python3-venv vlc -y
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
}

setup_shell_environment() {
    echo 'if [ -f ~/.aliases ]; then
       . ~/.aliases
    fi' >> ~/.bashrc

    curl -sS https://starship.rs/install.sh | sh
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
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
    dirs_to_config=("./home/.config/Code" "./home/.config/alacritty" "./home/.config/nvim" "./home/.config/nvim_packer")
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

setup_neovim() {
    curl -sLO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    ./nvim.appimage --appimage-extract
    ./squashfs-root/AppRun --version
    sudo mv squashfs-root /
    sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
}

main() {
    install_packages
    setup_shell_environment
    setup_fzf
    manage_ssh_keys
    manage_stash_repo
    copy_dotfiles
    setup_neovim
}

main
