{inputs, ...}: {
  programs.git = {
    enable = true;
    userName = "Addison Hernandez";
    userEmail = "addison.hernandez@gmail.com";
    aliases = {
      br = "branch";
      ci = "commit";
      civ = "commit --verbose";
      co = "checkout";
      ff = "merge --ff-only";
      freeze = "update-index --skip-worktree";
      thaw = "update-index --no-skip-worktree";
      logadog = "log --all --decorate --oneline --graph";
      rv = "remote --verbose";
      st = "status";
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
        path = "${inputs.catppuccin-delta.outPath}/catppuccin.gitconfig";
      };
      commit.verbose = "true";
      diff.colorMoved = "default";
      fetch.prune = "true";
      help.autocorrect = "50";
      init.defaultBranch = "main";
      merge.conflictStyle = "diff3";
    };
  };
}
