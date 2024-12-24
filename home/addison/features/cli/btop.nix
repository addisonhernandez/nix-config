{inputs, ...}: {
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "catppuccin_macchiato";
      theme_background = false;
      update_ms = 1000;
      disks_filter = "exclude=/nix /home /var/log";
    };
  };

  xdg.configFile."btop/themes".source = "${inputs.catppuccin-btop.outPath}/themes";
}
