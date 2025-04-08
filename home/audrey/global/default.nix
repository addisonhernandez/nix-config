{
  lib,
  config,
  inputs,
  outputs,
  ...
}:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    ./catppuccin.nix

    ../features/cli
  ] ++ (builtins.attrValues outputs.homeManagerModules or { });

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "audrey";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "24.05";
    sessionPath = [ "$HOME/.local/bin" ];
  };
}
