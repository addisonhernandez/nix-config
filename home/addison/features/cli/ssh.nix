{ config, ... }:
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
  sshDir = config.home.homeDirectory + "/.ssh";
in
{
  programs.ssh = {
    enable = true;

    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        # Settings formerly set by `programs.ssh.enableDefaultConfig`
        addKeysToAgent = "no";
        compression = false;
        controlMaster = "no";
        controlPath = "${sshDir}/master-%r@%n:%p";
        controlPersist = "no";
        forwardAgent = false;
        hashKnownHosts = false;
        serverAliveCountMax = 3;
        serverAliveInterval = 0;
        userKnownHostsFile = "${sshDir}/known_hosts";
      };

      "codeberg.org" = {
        addKeysToAgent = "yes";
        identityFile = "${sshDir}/codeberg";
        user = "git";
      };
      "github.com" = {
        addKeysToAgent = "yes";
        identityFile = "${sshDir}/github";
        user = "git";
      };
      "git.sr.ht" = {
        addKeysToAgent = "yes";
        identityFile = "${sshDir}/sourcehut";
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
