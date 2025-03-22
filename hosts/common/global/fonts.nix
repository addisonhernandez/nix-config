{ pkgs, ... }:
{
  # Install some fonts
  fonts = {
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/config/fonts/packages.nix#L42
    enableDefaultPackages = true;

    # Create a directory with links to all fonts in
    # `/run/current-system/sw/share/X11/fonts`
    fontDir.enable = true;

    packages = with pkgs; [
      # mono / programming
      nerd-fonts.fira-code
      maple-mono
      monaspace
      source-code-pro

      # general use
      inter
      lato

      # icons / symbols
      font-awesome
      # joypixels # requires manually accepting an unfree license

      # math
      fira-math
      lmmath

      # CJK
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];

    fontconfig.defaultFonts = {
      monospace = [
        "FiraCode Nerd Font"
        "Source Code Pro"
      ];
      sansSerif = [
        "Inter"
        "Lato"
        "Noto Sans CJK JP"
      ];
      serif = [
        "Noto Serif"
        "Noto Serif CJK JP"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
