{
  programs.fzf = {
    enable = true;
    defaultOptions = [
      # Ignore dev and build artifact directories
      "--walker-skip=.git,node_modules,.direnv,result"
    ];
    historyWidget.command = "";
  };
  catppuccin.fzf.enable = true;
}
