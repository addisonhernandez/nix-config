{
  nix = {
    sshServe = {
      enable = true;
      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFJqI/2o5wYn5xynfJWledJzbvrLgGqWlt5v1iC/iism nix-ssh"
      ];
      protocol = "ssh-ng";
      write = true;
    };
    settings.trusted-users = [ "nix-ssh" ];
  };
}
