#!/usr/bin/env bash

install_packages() {
    sudo apt update -y && sudo apt upgrade -y
    sudo apt install curl wget tmux ansible i3 ripgrep feh \
        python3-launchpadlib python3-venv vlc pavucontrol brightnessctl -y

    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

    sudo chmod +s "$(which brightnessctl)"
}

setup_shell_environment() {
    curl -sS https://starship.rs/install.sh | sh
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
    ansible-vault encrypt ./keys/*
}

manage_stash_repo() {
    mkdir -p ~/.db
    git clone git@github.com:musaubrian/stash
    ansible-vault decrypt ./stash/db/* ./stash/wakatime/*
    cp ./stash/db/* ~/.db/ -v
    cp ./stash/wakatime/wakatime.cfg ~/.wakatime.cfg -v
    ansible-vault encrypt ./stash/db/* ./stash/wakatime/*
}

create_symlinks() {
    create_symlink() {
        local src="$(realpath "$1")"
        local dest="$2"

        if [ -e "$dest" ] || [ -L "$dest" ]; then
            echo "Backing up $dest to ${dest}.backup"
            mv "$dest" "${dest}.backup"
        fi

        mkdir -p "$(dirname "$dest")"
        ln -sf "$src" "$dest"
        echo "Created symlink: $dest -> $src"
    }

    local home_files=(
        "./home/.bash_completions"
        "./home/.bashrc"
        "./home/.gitconfig"
        "./home/.profile"
        "./home/.tmux.conf"
        "./home/.zshrc"
        "./home/.aliases"
    )

    local home_dirs=(
        "./home/.fonts"
        "./home/.local"
        "./home/scripts"
    )

    local config_dirs=(
        "./home/.config/Code"
        "./home/.config/alacritty"
        "./home/.config/nvim"
        "./home/.config/kitty"
        "./home/.config/wezterm"
        "./home/.config/i3"
    )

    local config_files=(
        "./home/.config/starship.toml"
    )

    for file in "${home_files[@]}"; do
        create_symlink "$file" "$HOME/$(basename "$file")"
    done

    for dir in "${home_dirs[@]}"; do
        create_symlink "$dir" "$HOME/$(basename "$dir")"
    done

    mkdir -p "$HOME/.config"
    for dir in "${config_dirs[@]}"; do
        create_symlink "$dir" "$HOME/.config/$(basename "$dir")"
    done

    for file in "${config_files[@]}"; do
        create_symlink "$file" "$HOME/.config/$(basename "$file")"
    done
}

setup_trackpad() {
    sudo mkdir -p /etc/X11/xorg.conf.d/
    sudo ln -sf "$(realpath ./home/90-touchpad.conf)" "/etc/X11/xorg.conf.d/90-touchpad.conf"
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
    # Nice QoL
    git remote remove origin main
    git remode add origin main git@github.com:musaubrian/dotfiles
}

setup_wezterm() {
    curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
    echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
    sudo apt update -y
    sudo apt install wezterm -y
}

main() {
    mkdir -p "$HOME/personal" "$HOME/work"
    git clone http://github.com/musaubrian/dotfiles "$HOME/personal/dotfiles"
    cd "$HOME/personal/dotfiles" || exit

    install_packages
    setup_shell_environment
    setup_fzf
    setup_wezterm
    manage_ssh_keys
    manage_stash_repo
    create_symlinks
    setup_trackpad
    setup_neovim
    clean_up
}

main
