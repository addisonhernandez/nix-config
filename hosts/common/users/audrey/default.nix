{ config, ... }:
let
  ifTheyExist = builtins.filter (group: builtins.hasAttr group config.users.groups);
in
{
  users = {
    # mutableUsers = false;
    users.audrey = {
      isNormalUser = true;
      description = "Audrey";
      extraGroups = ifTheyExist [
        "networkmanager"
        "wheel"
      ];
      createHome = true;
      home = "/home/audrey";
      initialHashedPassword = "$y$j9T$/Ykp57kEluftnhkpGhKYZ/$4zBK6y1/WGlbG/lrF.G3u5bdn5XdgAbV6SAH5Q.f1W/";
    };
  };
}
