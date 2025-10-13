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
    ./lazydocker.nix
    ./nix-index.nix
    ./ssh.nix
    ./starship.nix
    ./tldr.nix
    ./zellij.nix
    ./zoxide.nix
  ];

  home.sessionVariables = {
    SHELL = lib.getExe (
      let
        inherit (config.programs) fish bash;
      in
      if fish.enable then fish.package else bash.package
    );
    EDITOR = lib.getExe pkgs.helix;
    VISUAL = lib.getExe pkgs.helix;
  };

  home.packages = with pkgs; [
    # Utilities
    delta # diff tool
    eza # better ls
    fastfetch
    fd # better find
    glow # render markdown in the terminal
    hyperfine # benchmarking tool
    jless # TUI JSON viewer
    jq # JSON CLI tool
    just # command runner
    lsof # list open files and ports
    p7zip # archiver
    ripgrep # better grep (provides `rg`)
    sd # better sed

    # Nix / NixOS utilities
    nh # nix CLI helper
    nil # nix LSP written in Rust
    nix-diff # detailed difftool
    nix-output-monitor # more output info while building (provides `nom`)
    nixd # nix LSP
    nixfmt-rfc-style # new nix formatter
    nvd # difftool
  ];
}
