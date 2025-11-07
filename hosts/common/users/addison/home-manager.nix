{
  config,
  inputs,
  pkgs,
  ...
}:
{
  users.users.addison.packages = [
    inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  home-manager.users = {
    addison = import "${inputs.self}/home/addison/${config.networking.hostName}.nix";
  };
}
