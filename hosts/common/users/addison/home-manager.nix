{
  config,
  inputs,
  pkgs,
  ...
}:
{
  users.users.addison.packages = [ pkgs.inputs.home-manager.default ];
  home-manager.users = {
    addison = import "${inputs.self}/home/addison/${config.networking.hostName}.nix";
  };
}
