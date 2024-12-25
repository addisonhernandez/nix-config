{...}: {
  programs.yazi = {
    enable = true;

    settings = {
      # https://yazi-rs.github.io/docs/configuration/yazi
      manager = {
        ratio = [1 4 5];
        sort_by = "natural";
        sort_dir_first = true;
      };
      preview = {
        tab_size = 2;
      };
    };
  };

  catppuccin.yazi.enable = true;
}
