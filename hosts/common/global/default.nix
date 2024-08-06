# Config options common to all hosts
{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./locale.nix
      ./fonts.nix

      ./fish.nix
      ./openssh.nix
      # ./podman.nix TODO
      ./tailscale.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

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
