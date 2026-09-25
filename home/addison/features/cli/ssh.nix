{ outputs, ... }:
let
  # [todo] use a snippet in @/modules/home-manager to abstract this
  nixosHostNames =
    outputs.hostnames
    |> map (host: "${host} ${host}.lan ${host}.beefalo-spica.ts.net")
    |> builtins.concatStringsSep " ";
  gitForgeDefaults = {
    AddKeysToAgent = "yes";
    User = "git";
  };
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        # Settings formerly set by `programs.ssh.enableDefaultConfig`
        AddKeysToAgent = "no";
        Compression = false;
        ControlMaster = "no";
        ControlPath = "%d/.ssh/master-%r@%n:%p";
        ControlPersist = "no";
        ForwardAgent = false;
        HashKnownHosts = false;
        ServerAliveCountMax = 3;
        ServerAliveInterval = 0;
        UserKnownHostsFile = "%d/.ssh/known_hosts";
      };

      "codeberg.org" = gitForgeDefaults // {
        IdentityFile = "%d/.ssh/codeberg";
      };
      "github.com" = gitForgeDefaults // {
        IdentityFile = "%d/.ssh/github";
      };
      "git.sr.ht" = gitForgeDefaults // {
        IdentityFile = "%d/.ssh/sourcehut";
      };
      "tangled.sh" = gitForgeDefaults // {
        IdentityFile = "%d/.ssh/tangled";
      };

      ${nixosHostNames} = {
        AddKeysToAgent = "yes";
        ForwardX11 = true;
        SetEnv.COLORTERM = "truecolor";
      };
    };
  };
}
