{
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports =
    [
      ../features/cli
      ../features/nvim
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "addison";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "24.05";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      SHELL = lib.getExe pkgs.fish;
      EDITOR = lib.getExe pkgs.lunarvim;
      VISUAL = lib.getExe pkgs.lunarvim;
      # PAGER = lib.getExe pkgs.bat;
    };
  };
}
