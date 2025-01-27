#!/usr/bin/env bash


manage_keys() {
    mkdir -p ~/.ssh
    ansible-vault decrypt ./keys/*
    cp -rv ./keys/* ~/.ssh/
    ansible-vault encrypt ./keys/*
}

manage_stash() {
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
        rm -rfv "$dest"
        ln -sfv "$src" "$dest"
    }

    local home_files=(
    "./home/.bash_completions"
    "./home/.bashrc"
    "./home/.gitconfig"
    "./home/.profile"
    "./home/.tmux.conf"
    "./home/.aliases"
)

local home_dirs=("./home/scripts")
local config_dirs=(
"./home/.config/nvim"
"./home/.config/foot"
"./home/.config/hypr"
"./home/.config/waybar"
)
local config_files=(
"./home/.config/starship.toml"
)

# mkdir -p "$HOME/.local" "$HOME/.config/Code/User"
#
# create_symlink "$(realpath ./home/.config/Code/User/settings.json)" "$HOME/.config/Code/User/settings.json"
# create_symlink "$(realpath ./home/.config/Code/User/keybinds.json)" "$HOME/.config/Code/User/keybindings.json"

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
    sudo ln -svf "$(realpath ./home/90-touchpad.conf)" "/etc/X11/xorg.conf.d/90-touchpad.conf"
}

main() {
    mkdir -p "$HOME/personal" "$HOME/work" "$HOME/thirdparty"
    sudo ln -sfv  "$(realpath ./home/configuration.nix)" /etc/nixos/configuration.nix

    echo "Building NixOS..."
    sudo nixos-rebuild switch &>/tmp/nixos-switch.log || \
        (cat /tmp/nixos-switch.log | grep error && false)

    manage_keys
    manage_stash
    create_symlinks
    # setup_trackpad

    # clean up
    git remote remove origin
    git remote add origin git@github.com:musaubrian/dotfiles
}

main
