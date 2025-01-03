{
  programs.ssh = {
    enable = true;

    addKeysToAgent = "yes";

    matchBlocks = {
      "codeberg.org" = {
        user = "git";
        identityFile = "~/.ssh/codeberg";
      };
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/github";
      };
    };
  };
}
