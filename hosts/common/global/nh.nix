{...}: {
  programs.nh = {
    enable = true;
    # flake = "${builtins.getEnv "HOME"}/.config/nix-config";

    clean.enable = true;
    clean.extraArgs = "--keep 3 --keep-since 14d";
  };
}
