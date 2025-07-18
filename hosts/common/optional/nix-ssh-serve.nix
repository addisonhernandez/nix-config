{ inputs, ... }:
{
  nix.sshServe = {
    enable = true;
    keys = [ (builtins.readFile "${inputs.secrets}/public_keys/nix-ssh.pub") ];
    protocol = "ssh-ng";
    trusted = true; # add nix-ssh user to `nix.settings.trusted-users`
    write = true;
  };
}
