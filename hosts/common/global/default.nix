# Config options common to all hosts
{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports =
    [
      inputs.catppuccin.nixosModules.catppuccin
      inputs.home-manager.nixosModules.home-manager
      ./catppuccin.nix
      ./firefox.nix
      ./fish.nix
      ./fonts.nix
      ./locale.nix
      ./nix.nix
      ./nh.nix
      ./openssh.nix
      ./podman.nix
      ./tailscale.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  boot.tmp.cleanOnBoot = true;

  environment.systemPackages = with pkgs; [
    lunarvim
  ];

  home-manager = {
    backupFileExtension = "bak";
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs outputs;};
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config.allowUnfree = true;
  };

  hardware.enableRedistributableFirmware = true;
}
