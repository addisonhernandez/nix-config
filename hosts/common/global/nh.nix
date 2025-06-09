{ config, configRoot, ... }:
{
  programs.nh = {
    enable = true;

    clean.enable = true;
    clean.extraArgs = "--keep 3 --keep-since 7d";

    flake = "git+https://codeberg.org/addison/nix-config";
  };

  environment.variables = {
    NH_OS_FLAKE = "${configRoot}#${config.system.name}";
  };
}
