{...}: {
  programs.btop = {
    enable = true;
    settings = {
      theme_background = false;
      update_ms = 1000;
      disks_filter = "exclude=/nix /home /var/log";
    };
  };

  catppuccin.btop.enable = true;
}
