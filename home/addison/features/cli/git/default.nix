{
  imports = [ ./delta.nix ];
  programs.git = {
    enable = true;
    userName = "Addison Hernandez";
    userEmail = "addison.hernandez@gmail.com";
    aliases = {
      br = "branch";
      ci = "commit";
      civ = "commit --verbose";
      co = "checkout";
      comp = "-c delta.side-by-side=true diff --ignore-space-change";
      fest = "!fest() { git fetch $@; git st }; fest";
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
    extraConfig = {
      commit.verbose = "true";
      diff.colorMoved = "default";
      fetch.prune = "true";
      help.autocorrect = "50";
      init.defaultBranch = "main";
      merge.conflictStyle = "diff3";
    };
  };
}
