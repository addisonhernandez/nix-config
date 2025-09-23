# Config options common to all hosts
{ outputs, ... }:
{
  imports = [
    ./agenix.nix
    ./catppuccin.nix
    ./editors.nix
    ./firefox.nix
    ./fish.nix
    ./flatpak.nix
    ./fonts.nix
    ./home-manager.nix
    ./librewolf.nix
    ./locale.nix
    ./nh.nix
    ./nix.nix
    ./nixpkgs.nix
    ./openssh.nix
    ./pay-respects.nix
    ./pipewire.nix
    ./systemd-boot.nix
    ./tailscale.nix
    ./udisks.nix
    ./xserver.nix
  ]
  ++ (builtins.attrValues outputs.nixosModules or { });

  boot.tmp.cleanOnBoot = true;

  hardware.enableAllFirmware = true;
}
