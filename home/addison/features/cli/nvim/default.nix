{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;

    withPython3 = false;
    withRuby = false;

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
