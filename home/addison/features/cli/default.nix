{pkgs, ...}: {
  imports = [
    ./atuin.nix
    ./bash.nix
    ./direnv.nix
    ./fish.nix
    ./git.nix
    ./nix-index.nix
    ./starship.nix
  ];

  home.packages = with pkgs; [
    # Escape hatch
    distrobox

    # Utilities
    bat # better cat
    delta # diff tool
    eza # better ls
    fastfetch
    fd # better find
    fzf # fuzzy finder
    glow # render markdown in the terminal
    jq # JSON CLI tool
    just # command runner
    lf # TUI file manager
    lsof # list open files and ports
    p7zip # archiver
    ranger # TUI file manager
    ripgrep # better grep (provides `rg`)
    tealdeer # short manpage examples
    zoxide # better cd

    # Nix / NixOS utilities
    alejandra # nix formatter
    # TODO: make a separate nh.nix config
    # see: https://github.com/viperML/nh#nixos-module
    nh # wrapper for NixOS and HM
    nil # nix LSP written in Rust
    nix-diff # detailed difftool
    nix-output-monitor # more output info while building (provides `nom`)
    nixd # nix LSP
    nvd # difftool
  ];
}
