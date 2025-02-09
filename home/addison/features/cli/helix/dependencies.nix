{ pkgs, ... }:
{
  programs.helix.extraPackages = with pkgs; [
    # LSPs
    # basedpyright # python
    bash-language-server
    docker-compose-language-service
    fish-lsp
    jq-lsp
    lua-language-server
    marksman # markdown
    nil
    nixd
    taplo # toml
    yaml-language-server

    # Plugin dependencies
    gcc
    gnumake
    unzip
    wl-clipboard
    xclip
    xsel
  ];
}
