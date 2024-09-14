let
  catppuccinTheme = builtins.fetchurl {
    url = "https://github.com/catppuccin/delta/raw/main/catppuccin.gitconfig";
    sha256 = "sha256:0s36qb2yb3dx4krj3fv7zh4hdd30nr1ms7zm4s8njx8aa2bxw8d1";
  };
in {
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
        path = "${catppuccinTheme}";
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
