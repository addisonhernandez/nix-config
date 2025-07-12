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

  home-manager.users = {
    audrey = import "${inputs.self}/home/audrey/${config.networking.hostName}.nix";
  };
}
