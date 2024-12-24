{pkgs, ...}: {
  imports = [
    ./lvim

    ./atuin.nix
    ./bash.nix
    ./bat.nix
    ./btop.nix
    ./direnv.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./nix-index.nix
    ./ranger.nix
    ./ssh.nix
    ./starship.nix
    ./yazi.nix
    ./zellij.nix
  ];

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
    lf # TUI file manager
    lsof # list open files and ports
    p7zip # archiver
    ripgrep # better grep (provides `rg`)
    tealdeer # short manpage examples
    zoxide # better cd

    # Nix / NixOS utilities
    alejandra # nix formatter
    nil # nix LSP written in Rust
    nixfmt-rfc-style # new nix formatter
    nix-diff # detailed difftool
    nix-output-monitor # more output info while building (provides `nom`)
    nixd # nix LSP
    nvd # difftool
  ];
}
