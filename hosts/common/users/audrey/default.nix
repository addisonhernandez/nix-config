{
  config,
  inputs,
  pkgs,
  ...
}:
{
  users.users.audrey = {
    isNormalUser = true;
    description = "Audrey";
    extraGroups = builtins.filter (g: builtins.hasAttr g config.users.groups) [
      "git"
      "networkmanager"
      "media"
      "samba"
      "wheel"
    ];
    createHome = true;
    home = "/home/audrey";
    hashedPasswordFile = config.age.secrets.audreyPasswordsNixOS.path;

    packages = [
      pkgs.fromInput.home-manager.default
      pkgs.onlyoffice-desktopeditors
    ];
  };

  age.secrets.audreyPasswordsNixOS.file = "${inputs.secrets}/users/audrey/passwords/nixos.age";

  home-manager.users = {
    audrey = import "${inputs.self}/home/audrey/${config.networking.hostName}.nix";
  };
}
