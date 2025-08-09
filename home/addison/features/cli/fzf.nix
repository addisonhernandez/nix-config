{
  programs.fzf.enable = true;
  programs.fzf.defaultOptions = [
    # Ignore dev and build artifact directories
    "--walker-skip=.git,node_modules,.direnv,result"
  ];
  catppuccin.fzf.enable = true;
}
