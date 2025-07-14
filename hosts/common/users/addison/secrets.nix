{ config, inputs, ... }:
{
  age.secrets.addisonPasswordsNixOS.file = "${inputs.secrets}/users/addison/passwords/nixos.age";
  users.users.addison = {
    hashedPasswordFile = config.age.secrets.addisonPasswordsNixOS.path;
  };
}
