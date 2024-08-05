# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
} @ inputs: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hedgehog"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "us";
      options = "caps:escape_shifted_capslock";
    };
  };

  # Duplicate X11 keymap in console (tty)
  console.useXkbConfig = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    addison = {
      isNormalUser = true;
      description = "Addison";
      extraGroups = ["networkmanager" "wheel"];
    };
    audrey = {
      isNormalUser = true;
      description = "Audrey";
      extraGroups = ["networkmanager" "wheel"];
      createHome = true;
      home = "/home/audrey";
      initialHashedPassword = "$y$j9T$/Ykp57kEluftnhkpGhKYZ/$4zBK6y1/WGlbG/lrF.G3u5bdn5XdgAbV6SAH5Q.f1W/";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.dash-to-dock
    gnomeExtensions.pop-shell
    gnomeExtensions.vitals

    gnome.gnome-tweaks
    gnome.sushi

    # System theming
    (catppuccin-gtk.override {
      # [ "blue" "flamingo" "green" "lavender" "maroon" "mauve" "peach"
      #   "pink" "red" "rosewater" "sapphire" "sky" "teal" "yellow" ]
      accents = ["mauve"]; # ? ["blue"]

      # [ "standard" "compact" ]
      # size = "compact"; # ? "standard"

      # [ "black" "rimless" "normal" ]
      tweaks = ["rimless" "normal" "black"]; # ? [ ]

      # [ "latte" "frappe" "macchiato" "mocha" ]
      variant = "macchiato"; # ? "frappe"
    })
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
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      symbola
      twemoji-color-font
    ];
    fontconfig = {
      defaultFonts = {
        monospace = ["FiraCode Nerd Font" "Source Code Pro" "Monospace"];
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services = {
    flatpak.enable = true;

    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  # Enable experimental flake functionality
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
