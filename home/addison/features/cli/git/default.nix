{
  imports = [ ./delta.nix ];
  programs.git = {
    enable = true;
    userName = "Addison Hernandez";
    userEmail = "addison.hernandez@gmail.com";
    aliases = {
      ci = "commit";
      co = "checkout";
      comp = "-c delta.side-by-side=true diff --ignore-space-change";
      fest = "!_git_fest() { git fetch; git st; }; _git_fest";
      ff = "merge --ff-only";
      fog = "!_git_fog() { git fetch; git logadog main^..origin/main; }; _git_fog";
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
      branch.sort = "-committerdate";
      column.ui = "auto";
      commit.verbose = "true";
      # core.untrackedCache = "true";
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = "true";
        renames = "true";
      };
      fetch.prune = "true";
      fetch.pruneTags = "true";
      help.autocorrect = "prompt";
      init.defaultBranch = "main";
      merge.conflictStyle = "zdiff3";
      # pull.rebase = "true";
      push.autoSetupRemote = "true";
      rebase = {
        autoSquash = "true";
        autoStash = "true";
        updateRefs = "true";
      };
      rerere.enabled = "true";
      rerere.autoUpdate = "true";
      tag.sort = "version:refname";
    };
  };
}
