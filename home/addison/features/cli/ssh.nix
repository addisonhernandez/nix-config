{ config, ... }:
let
  # [todo] use a snippet in @/modules/home-manager to abstract this
  nixosHostNames =
    [
      "greenbeen"
      "hedgehog"
      "jeeves"
      "vulcan"
    ]
    |> map (host: "${host} ${host}.lan ${host}.beefalo-spica.ts.net")
    |> builtins.concatStringsSep " ";
  sshDir = config.home.homeDirectory + "/.ssh";
  defaultBlockSettings = {
    addKeysToAgent = "yes";
    user = "git";
  };
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

      "codeberg.org" = defaultBlockSettings // {
        identityFile = "${sshDir}/codeberg";
      };
      "github.com" = defaultBlockSettings // {
        identityFile = "${sshDir}/github";
      };
      "git.sr.ht" = defaultBlockSettings // {
        identityFile = "${sshDir}/sourcehut";
      };
      "tangled.sh" = defaultBlockSettings // {
        identityFile = "${sshDir}/tangled";
      };

      ${nixosHostNames} = {
        addKeysToAgent = "yes";
        forwardX11 = true;
        setEnv.COLORTERM = "truecolor";
      };
    };
  };
}
