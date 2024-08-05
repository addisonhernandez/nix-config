# home-manager config for addison @ hedgehog
{pkgs, ...}: {
  imports = [
    ./global
  ];

  home.packages = with pkgs; [
    fastfetch
    glow
    nerdfetch
    p7zip
  ];

  programs = let
    inherit (pkgs.lib.attrsets) genAttrs;

    # Map a list of program names to a set that enables them
    # eg. enablePrograms [ "foo" ] -> { foo.enable = true; }
    enablePrograms = progList: genAttrs progList (prog: {enable = true;});

    # Import configs from ./features/<name>.nix
    addProgram = name: import (./features + "/${name}.nix");
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
      # These require a config file at ./features/<name>.nix
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
