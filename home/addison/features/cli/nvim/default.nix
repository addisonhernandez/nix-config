{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    # defaultEditor = true;

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
