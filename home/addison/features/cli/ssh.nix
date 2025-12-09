{ config, lib, ... }:
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
        extraOptions = lib.mkIf config.programs.fish.enable {
          # Do not use `lib.getExe` to get a path to the nix store fish binary.
          # Instead allow the remote host to use path lookup to allow different
          # versions of fish across hosts.
          RemoteCommand = ''fish --login'';
        };
        forwardX11 = true;
        # [todo] this option doesn't exist for some reason. define it?
        # remoteCommand = lib.mkIf config.programs.fish.enable ''
        #   # Do not use `lib.getExe` to get a path to the nix store fish binary.
        #   # Instead allow the remote host to use path lookup to allow different
        #   # versions of fish across hosts.
        #   fish --login
        # '';
        sendEnv = [
          "COLORTERM"
          "WAYLAND_DISPLAY"
        ];
      };
    };
  };
}
