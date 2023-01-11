# nvim-config
> my dotfiles mostly neovim

### **cc [@prime](https://github.com/thePrimeagen/init.lua)**

### neovim

> **Note**
> make sure you have the latest **stable** neovim


```sh
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    ./nvim.appimage

    ./nvim.appimage --appimage-extract
    ./squashfs-root/AppRun --version
    # Optional: exposing nvim globally.
    sudo mv squashfs-root /
    sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

    nvim 
```


```sh
:PackerSync
```
