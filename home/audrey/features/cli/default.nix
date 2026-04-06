{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./git
    ./helix
    ./nvim
    ./yazi

    ./atuin.nix
    ./bash.nix
    ./bat.nix
    ./btop.nix
    ./direnv.nix
    ./fish.nix
    ./fzf.nix
    ./nix-index.nix
    ./ssh.nix
    ./starship.nix
    ./tldr.nix
    ./zellij.nix
    ./zoxide.nix
  ];

  home.sessionVariables =
    let
      inherit (config.programs) bash fish helix;
      userShell = if fish.enable then fish else bash;
    in
    {
      SHELL = lib.getExe userShell.package;
      EDITOR = lib.getExe helix.package;
      VISUAL = lib.getExe helix.package;
    };

  home.packages = with pkgs; [
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
    nh # nix CLI helper
    nil # nix LSP written in Rust
    nix-diff # detailed difftool
    nix-output-monitor # more output info while building (provides `nom`)
    nixd # nix LSP
    nixfmt # nix formatter
    nvd # difftool
  ];
}
