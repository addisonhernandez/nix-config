# Config options common to all hosts
{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.agenix.nixosModules.default
    inputs.catppuccin.nixosModules.default
    inputs.home-manager.nixosModules.default
    ./catppuccin.nix
    ./editors.nix
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
    ./systemd-boot.nix
    ./tailscale.nix
    ./udisks.nix
    ./xserver.nix
  ] ++ (builtins.attrValues outputs.nixosModules or { });

  boot.tmp.cleanOnBoot = true;

  environment.systemPackages = [ pkgs.librewolf ];

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
