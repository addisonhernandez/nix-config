{
  lib,
  config,
  inputs,
  outputs,
  ...
}:
{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
    ./catppuccin.nix

    ../features/cli
  ] ++ (builtins.attrValues outputs.homeManagerModules or { });

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "addison";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "24.05";
    sessionPath = [ "$HOME/.local/bin" ];
    sessionVariables = {
      FLAKE = "${config.xdg.configHome}/nix-config";
    };
  };
}
