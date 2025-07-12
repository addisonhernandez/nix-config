{
  programs.nh = {
    enable = true;

    clean.enable = true;
    clean.extraArgs = "--keep 3 --keep-since 7d";

    flake = "git+https://codeberg.org/addison/nix-config";
  };
}
