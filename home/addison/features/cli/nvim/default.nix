{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      gnumake
      unzip
      libgcc
      gcc_multi

      xclip
      xsel
      wl-clipboard
    ];
  };
}
