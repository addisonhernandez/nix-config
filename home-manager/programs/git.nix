{
  enable = true;
  userName = "Addison Hernandez";
  userEmail = "addison.hernandez@gmail.com";
  aliases = {
    co = "checkout";
    ci = "commit";
    civ = "commit --verbose";
    st = "status";
    br = "branch";
    logadog = "log --all --decorate --oneline --graph";
    freeze = "update-index --skip-worktree";
    rv = "remote --verbose";
  };
  ignores = [
    "*~"
    ".*.swp"
    ".DS_Store"
  ];
  delta = {
    enable = true;
    options = {
      navigate = "true";
      features = "catppuccin-macchiato";
    };
  };
  extraConfig = {
    include = {
      path = "$HOME/.themes/delta/catppuccin.gitconfig";
    };
    init = {
      defaultBranch = "main";
    };
    help = {
      autocorrect = "50";
    };
    merge = {
      conflictStyle = "diff3";
    };
    diff = {
      colorMoved = "default";
    };
    fetch = {
      prune = "true";
    };
    commit = {
      verbose = "true";
    };
  };
}
