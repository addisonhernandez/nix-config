{
  description = "NixOS and Home Manager Config Entrypoint";

  inputs = {
    ## Configuration building blocks
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.follows = "nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    systems.url = "github:nix-systems/x86_64-linux";

    ## Dendritic pattern inputs
    flake-aspects.url = "github:vic/flake-aspects";
    import-tree.url = "github:vic/import-tree";

    ## Flake inputs
    agenix.url = "github:ryantm/agenix";
    agenix.inputs = {
      nixpkgs.follows = "nixpkgs";
      home-manager.follows = "home-manager";
      systems.follows = "systems";
      darwin.follows = "";
    };

    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-db.url = "github:nix-community/nix-index-database";
    nix-index-db.inputs.nixpkgs.follows = "nixpkgs";

    secrets.url = "git+ssh://git@codeberg.org/addison/secrets.git?ref=main&shallow=1";
    secrets.inputs.agenix.follows = "agenix";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    ## Non-flake inputs
    # <name>.url = "...";
    # <name.flake = false;
  };

  outputs =
    { self, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      # [todo] migrate to `import-tree ./modules`
      imports = [ ./modules/flake ];

      # [todo] migrate to dendritic modules / aspects
      flake =
        let
          inherit (self) outputs;

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
        in
        {
          inherit lib;

          nixosModules = import ./modules/nixos;

          overlays = import ./overlays { inherit inputs; };

          nixosConfigurations = forEachHost lib.mkHostConfig;
          homeConfigurations = forEachHome lib.mkHomeConfig;
        };

      perSystem =
        { lib, pkgs, ... }:
        let
          pkgNames = builtins.attrNames (builtins.readDir ./pkgs);
        in
        {
          packages = lib.genAttrs pkgNames (name: pkgs.callPackage ./pkgs/${name} { });
        };
    };
}
