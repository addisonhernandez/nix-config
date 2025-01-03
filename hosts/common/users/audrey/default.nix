{
  pkgs,
  config,
  configRoot,
  ...
}:
let
  hostName = config.networking.hostName;
  ifTheyExist = builtins.filter (group: builtins.hasAttr group config.users.groups);
in
{
  users.users.audrey = {
    isNormalUser = true;
    description = "Audrey";
    extraGroups = ifTheyExist [
      "git"
      "networkmanager"
      "media"
      "wheel"
    ];
    createHome = true;
    home = "/home/audrey";
    initialHashedPassword = "$y$j9T$/Ykp57kEluftnhkpGhKYZ/$4zBK6y1/WGlbG/lrF.G3u5bdn5XdgAbV6SAH5Q.f1W/";

    packages = with pkgs; [
      home-manager
      onlyoffice-desktopeditors
    ];
  };

  home-manager.users.audrey = import "${configRoot}/home/audrey/${hostName}.nix";
}
