{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ls = "eza --color=auto";
      lx = "eza -lhAXF --group-directories-first";
      lt = "lx --tree --level=2";
    };
  };
}
