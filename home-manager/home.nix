{
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "addison";
  home.homeDirectory = "/home/addison";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    glow
    neofetch
    p7zip
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = let
    homeDir = config.home.homeDirectory;
    dotfilesDir = "${homeDir}/.config/dotfiles";
    themeDir = "${homeDir}/.themes/Catppuccin-Macchiato-Standard-Mauve-Dark/gtk-4.0";
    linkTo = config.lib.file.mkOutOfStoreSymlink;
  in {
    ".config/kitty/kitty.conf".source = linkTo "${dotfilesDir}/kitty.conf";
    ".config/ranger/rc.conf".source = linkTo "${dotfilesDir}/ranger/rc.conf";

    # Use gtk theme with GTK 4 apps
    ".config/gtk-4.0/assets".source = linkTo "${themeDir}/assets";
    ".config/gtk-4.0/gtk.css".source = linkTo "${themeDir}/gtk.css";
    ".config/gtk-4.0/gtk-dark.css".source = linkTo "${themeDir}/gtk-dark.css";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs = let
    inherit (pkgs.lib.attrsets) genAttrs;

    # Map a list of program names to a set that enables them
    # eg. enablePrograms [ "foo" ] -> { foo.enable = true; }
    enablePrograms = progList: genAttrs progList (prog: {enable = true;});

    # Import configs from ./programs/<name>.nix
    addProgram = name: import (./programs + "/${name}.nix");
    addConfiguredPrograms = progList: genAttrs progList addProgram;
  in
    {
      # Let Home Manager install and manage itself.
      home-manager.enable = true;
    }
    // enablePrograms [
      "btop"
      "fzf"
      "jq"
      "ripgrep"
      "zoxide"
    ]
    // addConfiguredPrograms [
      # These require a config file at ./programs/<name>.nix
      "atuin"
      "bash"
      "chromium"
      "direnv"
      "fish"
      "git"
      "neovim"
      "starship"
    ];
}
