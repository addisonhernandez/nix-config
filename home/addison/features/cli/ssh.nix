{ outputs, ... }:
let
  # [todo] use a snippet in @/modules/home-manager to abstract this
  nixosHostNames =
    outputs.hostnames
    |> map (host: "${host} ${host}.lan ${host}.beefalo-spica.ts.net")
    |> builtins.concatStringsSep " ";
  gitForgeDefaults = {
    addKeysToAgent = "yes";
    user = "git";
  };
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        # Settings formerly set by `programs.ssh.enableDefaultConfig`
        addKeysToAgent = "no";
        compression = false;
        controlMaster = "no";
        controlPath = "%d/.ssh/master-%r@%n:%p";
        controlPersist = "no";
        forwardAgent = false;
        hashKnownHosts = false;
        serverAliveCountMax = 3;
        serverAliveInterval = 0;
        userKnownHostsFile = "%d/.ssh/known_hosts";
      };

      "codeberg.org" = gitForgeDefaults // {
        identityFile = "%d/.ssh/codeberg";
      };
      "github.com" = gitForgeDefaults // {
        identityFile = "%d/.ssh/github";
      };
      "git.sr.ht" = gitForgeDefaults // {
        identityFile = "%d/.ssh/sourcehut";
      };
      "tangled.sh" = gitForgeDefaults // {
        identityFile = "%d/.ssh/tangled";
      };

      ${nixosHostNames} = {
        addKeysToAgent = "yes";
        forwardX11 = true;
        SetEnv.COLORTERM = "truecolor";
      };
    };
  };
}
