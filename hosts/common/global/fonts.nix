{pkgs, ...}: {
  # Install some fonts
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      fira-code-nerdfont
      inter
      monaspace
    ];

    fontconfig = {
      defaultFonts = {
        monospace = ["FiraCode Nerd Font" "Source Code Pro" "Monospace"];
        sansSerif = ["Inter" "DejaVu Sans"];
      };
    };
  };
}
