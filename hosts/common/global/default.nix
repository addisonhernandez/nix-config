# Config options common to all hosts
{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
    inputs.home-manager.nixosModules.home-manager
    ./catppuccin.nix
    ./docker.nix
    ./firefox.nix
    ./fish.nix
    ./flatpak.nix
    ./fonts.nix
    ./locale.nix
    ./nh.nix
    ./nix.nix
    ./openssh.nix
    ./pay-respects.nix
    ./pipewire.nix
    ./podman.nix
    ./systemd-boot.nix
    ./tailscale.nix
    ./udisks.nix
    ./xserver.nix
  ] ++ (builtins.attrValues outputs.nixosModules or { });

  boot.tmp.cleanOnBoot = true;

  environment.systemPackages = with pkgs; [
    helix
    lunarvim
    neovim
    zed-editor
  ];

  home-manager = {
    backupFileExtension = "bak";
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs outputs; };
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config.allowUnfree = true;
  };

  hardware.enableRedistributableFirmware = true;
}
