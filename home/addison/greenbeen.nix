{
  imports = [
    ./global

    ./features/cli/distrobox.nix

    ./features/desktop
    ./features/desktop/chromium.nix
    ./features/desktop/spotube.nix
  ];
}
