{
  lib,
  config,
  inputs,
  outputs,
  ...
}:
let
  waylandEnabled = (builtins.getEnv "XDG_SESSION_TYPE") == "wayland";
in
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
    } // { NIXOS_OZONE_WL = if waylandEnabled then 1 else 0; };
  };
}
