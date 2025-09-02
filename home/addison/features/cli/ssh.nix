let
  # [todo] use a snippet in @/modules/home-manager to abstract this
  nixosHostNames =
    builtins.concatMap
      (host: [
        host
        "${host}.lan"
        "${host}.beefalo-spica.ts.net"
      ])
      [
        "greenbeen"
        "hedgehog"
        "jeeves"
        "vulcan"
      ];
in
{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "*" = {
        # Settings formerly set by `programs.ssh.enableDefaultConfig`
        addKeysToAgent = "no";
        compression = false;
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
        forwardAgent = false;
        hashKnownHosts = false;
        serverAliveCountMax = 3;
        serverAliveInterval = 0;
        userKnownHostsFile = "~/.ssh/known_hosts";
      };

      "codeberg.org" = {
        addKeysToAgent = "yes";
        identityFile = "~/.ssh/codeberg";
        user = "git";
      };
      "github.com" = {
        addKeysToAgent = "yes";
        identityFile = "~/.ssh/github";
        user = "git";
      };

      "${builtins.concatStringsSep " " nixosHostNames}" = {
        addKeysToAgent = "yes";
        forwardX11 = true;
        setEnv.COLORTERM = "truecolor";
      };
    };
  };
}
