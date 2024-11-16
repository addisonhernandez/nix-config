{pkgs, ...}: {
  programs.steam = {
    enable = true;

    dedicatedServer.openFirewall = true;
    remotePlay.openFirewall = true;

    # gamescopeSession = {
    #   enable = true;
    #   args = [];
    #   env = {};
    # };

    protontricks.enable = true;

    extraPackages = with pkgs; [
      gamescope
    ];

    extraCompatPackages = with pkgs; [
      proton-ge-bin
      steamtinkerlaunch
    ];
  };

  programs.gamemode.enable = true;
}
