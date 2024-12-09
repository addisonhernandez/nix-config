{pkgs, ...}: {
  # Install some fonts
  fonts = {
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/config/fonts/packages.nix#L34
    enableDefaultPackages = true;

    packages = with pkgs; [
      # mono / programming
      nerd-fonts.fira-code
      jetbrains-mono
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
    ];

    fontconfig = {
      defaultFonts = {
        monospace = ["FiraCode Nerd Font" "Source Code Pro" "Monospace"];
        sansSerif = ["Inter" "Lato" "DejaVu Sans"];
        serif = ["Noto Serif"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
