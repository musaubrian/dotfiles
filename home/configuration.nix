# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    # ./hardware-configuration.nix
    /etc/nixos/hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "sminx"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = true;

  # Set your time zone.
  time.timeZone = "Africa/Nairobi";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ulong = {
    isNormalUser = true;
    description = "ulong";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #i3setup
  environment.pathsToLink = ["/libexec"];

  services.displayManager.defaultSession = "none+i3";

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = true;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        rofi
        i3lock
      ];
    };
  };

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  programs.xfconf.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    iosevka
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
    libgcc
    gcc
    gnumake
    sqlite
    pkgs.sshfs
    xclip
    xsel
    unzip
    tree
    cronie

    neovim
    feh
    pavucontrol
    brightnessctl
    fzf
    ripgrep
    starship
    wezterm
    fastfetch
    btop
    delta
    yt-dlp
    alejandra
    hugo
    uv #python stuff

    #neovim tools, basically yeet mason
    nil
    gopls
    lua-language-server
    marksman
    python312Packages.python-lsp-server
    typescript-language-server
    tailwindcss-language-server

    prettierd
    stylua
    phpactor
    ruff

    #lang related
    python312
    go
    rustup
    php83
    php83Packages.composer
    nodejs_22

    #applications
    xfce.thunar
    firefox
    mpv
    networkmanagerapplet
    ansible
    flameshot
    telegram-desktop
    android-studio
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  networking.firewall.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.allowedTCPPortRanges = [
    {
      from = 1000;
      to = 1500;
    }
    {
      from = 3000;
      to = 3500;
    }
    {
      from = 8000;
      to = 9000;
    }
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
