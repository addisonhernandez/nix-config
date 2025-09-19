{
  description = "NixOS and Home Manager Config Entrypoint";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.follows = "nixpkgs-unstable";

    systems.url = "github:nix-systems/x86_64-linux";
    hardware.url = "github:nixos/nixos-hardware";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs = {
      nixpkgs.follows = "nixpkgs";
      home-manager.follows = "home-manager";
      systems.follows = "systems";
      darwin.follows = "";
    };

    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";

    secrets.url = "git+ssh://git@codeberg.org/addison/secrets.git?ref=main&shallow=1";
    secrets.inputs.agenix.follows = "";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self, ... }@inputs:
    let
      inherit (self) outputs;
      inherit (lib) forEachSystem mkHomeConfig mkHostConfig;

      lib = import ./lib { inherit inputs outputs; };

      hostnames = [
        "greenbeen" # Mini Desktop (Beelink SER7)
        "hedgehog" # Laptop (Dell XPS 9560)
        "iso" # Custom installer image
        "jeeves" # Media Server (Beelink Mini S12 Pro)
        "vulcan" # Desktop
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

      treefmt = forEachSystem (
        pkgs: inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix
      );
    in
    {
      inherit lib;

      nixosModules = import ./modules/nixos;
      # homeModules = import ./modules/home-manager;

      overlays = import ./overlays { inherit inputs; };

      checks = forEachSystem (pkgs: {
        formatting = treefmt.${pkgs.system}.config.build.check self;
      });
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      formatter = forEachSystem (pkgs: treefmt.${pkgs.system}.config.build.wrapper);
      packages = forEachSystem (
        pkgs:
        (import ./pkgs { inherit pkgs; })
        // {
          inherit (self.nixosConfigurations.iso.config.system.build) isoImage;
        }
      );

      nixosConfigurations = forEachHost mkHostConfig;
      homeConfigurations = forEachHome mkHomeConfig;
    };
}
