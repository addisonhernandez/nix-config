{
  description = "NixOS and Home Manager Config Entrypoint";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    systems.url = "github:nix-systems/x86_64-linux";
    hardware.url = "github:nixos/nixos-hardware";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self, ... }@inputs:
    let
      inherit (self) outputs;
      inherit (lib) forEachSystem mkHomeConfig mkHostConfig;

      lib = import ./lib { inherit inputs outputs configRoot; };

      configRoot = ./.;

      hostnames = [
        "hedgehog" # Laptop (Dell XPS 9560)
        "vulcan" # Desktop
        "greenbeen" # Mini Desktop (Beelink SER7)
        "jeeves" # Media Server (Beelink Mini S12 Pro)
      ];
      usernames = [
        "addison"
        "audrey"
      ];
      userHostPairs = lib.cartesianProduct {
        user = usernames;
        host = hostnames;
      };

      forEachHost = lib.genAttrs hostnames;
      forEachHome = f: lib.mergeAttrsList (map f userHostPairs);
    in
    {
      inherit lib;

      # nixosModules = import ./modules/nixos;
      # homeManagerModules = import ./modules/home-manager;

      overlays = import ./overlays { inherit inputs outputs; };

      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      formatter = forEachSystem (pkgs: pkgs.alejandra);
      # packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });

      nixosConfigurations = forEachHost mkHostConfig;
      homeConfigurations = forEachHome mkHomeConfig;
    };
}
