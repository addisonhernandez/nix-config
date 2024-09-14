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
      SHELL = "${pkgs.fish}/bin/fish";
      EDITOR = "${pkgs.lunarvim}/bin/lvim";
      VISUAL = "${pkgs.lunarvim}/bin/lvim";
      PAGER = "${pkgs.bat}/bin/bat";
    };
  };
}
