# Config options common to all hosts
{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./fish.nix
      ./fonts.nix
      ./locale.nix
      ./nix.nix
      ./openssh.nix
      ./podman.nix
      ./tailscale.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  environment.systemPackages = with pkgs; [
    lunarvim
  ];

  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs outputs;};
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config.allowUnfree = true;
  };

  hardware.enableRedistributableFirmware = true;
}
