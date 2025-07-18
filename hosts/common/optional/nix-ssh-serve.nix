{ inputs, ... }:
{
  nix.sshServe = {
    enable = true;
    keys = [ (builtins.readFile "${inputs.secrets}/users/nix-ssh/public_keys/id/nix-ssh.pub") ];
    protocol = "ssh-ng";
    trusted = true; # add nix-ssh user to `nix.settings.trusted-users`
    write = true;
  };
}
