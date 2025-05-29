{ lib, pkgs, ... }:
{
  imports = [
    ./helix
    ./lvim
    ./nvim
    ./git

    ./atuin.nix
    ./bash.nix
    ./bat.nix
    ./btop.nix
    ./direnv.nix
    ./fish.nix
    ./fzf.nix
    ./nh.nix
    ./nix-index.nix
    ./ssh.nix
    ./starship.nix
    ./tldr.nix
    ./yazi.nix
    ./zellij.nix
    ./zoxide.nix
  ];

  home.sessionVariables = {
    SHELL = lib.getExe pkgs.fish;
    EDITOR = lib.getExe pkgs.helix;
    VISUAL = lib.getExe pkgs.helix;
  };

  home.packages = with pkgs; [
    # Escape hatch
    distrobox

    # Utilities
    delta # diff tool
    eza # better ls
    fastfetch
    fd # better find
    glow # render markdown in the terminal
    jq # JSON CLI tool
    just # command runner
    lsof # list open files and ports
    p7zip # archiver
    ripgrep # better grep (provides `rg`)

    # Nix / NixOS utilities
    alejandra # nix formatter
    nh # nix CLI helper
    nil # nix LSP written in Rust
    nix-diff # detailed difftool
    nix-output-monitor # more output info while building (provides `nom`)
    nixd # nix LSP
    nixfmt-rfc-style # new nix formatter
    nvd # difftool
  ];
}
