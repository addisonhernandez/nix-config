# This takes the place of /etc/nixos/configuration.nix
{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.dell-xps-15-9560

    ./hardware-configuration.nix

    ../common/global
    ../common/users/addison

    #     ../common/optional/example1.nix
    #     ../common/optional/example2.nix
  ];

  networking = {
    hostName = "hedgehog";
    networkmanager.enable = true;

    #     Enables wireless support via wpa_supplicant.
    #     networking.wireless.enable = true;
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
  };

  # TODO: migrate the following into their own modules

  services = {
    xserver = {
      # Enable the X11 windowing system.
      enable = true;

      # Configure keymap in X11
      xkb = {
        layout = "us";
        options = "caps:escape_shifted_capslock";
      };
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  };

  # Duplicate X11 keymap in console (tty)
  console.useXkbConfig = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Install some stuff
  environment.systemPackages = with pkgs; [
    firefox
    kitty
    pop-launcher
    wireguard-tools
    qbittorrent

    # CLI/TUI
    fish
    ranger
    bat
    eza
    fd
    delta
    just
    tealdeer

    xclip
    xsel

    # Build tools
    gnumake
    unzip
    libgcc
    gcc

    # GNOME Extensions
    #     gnomeExtensions.appindicator
    #     gnomeExtensions.blur-my-shell
    #     gnomeExtensions.caffeine
    #     gnomeExtensions.dash-to-dock
    #     gnomeExtensions.pop-shell
    #     gnomeExtensions.vitals
    #
    #     gnome.gnome-tweaks
    #     gnome.sushi

    # System theming
    #     (catppuccin-gtk.override {
    #       # [ "blue" "flamingo" "green" "lavender" "maroon" "mauve" "peach"
    #       #   "pink" "red" "rosewater" "sapphire" "sky" "teal" "yellow" ]
    #       accents = ["mauve"]; # ? ["blue"]
    #
    #       # [ "standard" "compact" ]
    #       # size = "compact"; # ? "standard"
    #
    #       # [ "black" "rimless" "normal" ]
    #       tweaks = ["rimless" "normal" "black"]; # ? [ ]
    #
    #       # [ "latte" "frappe" "macchiato" "mocha" ]
    #       variant = "macchiato"; # ? "frappe"
    #     })
  ];

  # Move configuration.nix & hardware-configuration.nix to the dotfiles directory
  environment.etc = let
    inherit (pkgs.lib) filesystem strings;

    dotfilesDir = /home/addison/.config/dotfiles;
    nixConfDir = dotfilesDir + /nixos;

    nixConfFiles = filesystem.listFilesRecursive nixConfDir;

    trimDotfilesPrefix = strings.removePrefix "${dotfilesDir}/";
  in
    builtins.foldl'
    (acc: elem: acc // {${trimDotfilesPrefix (toString elem)}.source = elem;})
    {}
    nixConfFiles;

  # Install some fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      fira-code-nerdfont
      monaspace
    ];
    fontconfig = {
      defaultFonts = {
        monospace = ["FiraCode Nerd Font" "Source Code Pro" "Monospace"];
      };
    };
  };

  # List services that you want to enable:
  services = {
    openssh.enable = true;

    flatpak.enable = true;

    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
