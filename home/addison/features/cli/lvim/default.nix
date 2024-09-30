{config, ...}: let
  confDir = "${config.home.homeDirectory}/.config/lvim";
in {
  home.file."${confDir}/config.lua".source = ./config.lua;
}
