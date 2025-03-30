{
  lib,
  config,
  inputs,
  outputs,
  ...
}:
let
  waylandEnabled =
    true # FIXME: figure out a good way to detect wayland support from HM at build time
    # || config.services.desktopManager.plasma6.enable
    # || config.services.displayManager.defaultSession == "plasma"
    || (builtins.getEnv "XDG_SESSION_TYPE") == "wayland";
in
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
    username = lib.mkDefault "addison";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "24.05";
    sessionPath = [ "$HOME/.local/bin" ];
    sessionVariables = {
      FLAKE = "git+https://codeberg.org/addison/nix-config";
      NIXOS_OZONE_WL = if waylandEnabled then 1 else 0;
    };
  };
}
