{
  description = "NixOS and Home Manager Config Entrypoint";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    systems.url = "github:nix-systems/x86_64-linux";
    hardware.url = "github:nixos/nixos-hardware";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    home-manager-stable.url = "github:nix-community/home-manager/release-24.11";
    home-manager-stable.inputs.nixpkgs.follows = "nixpkgs-stable";

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs-stable";
        home-manager.follows = "home-manager";
        home-manager-stable.follows = "home-manager-stable";
      };
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      systems,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      lib = nixpkgs.lib // home-manager.lib;

      pkgsFor = lib.genAttrs (import systems) (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );
      forEachSystem = f: lib.genAttrs (import systems) (sys: f pkgsFor.${sys});

      configRoot = ./.;

      hostnames = [
        # Laptop (Dell XPS 9560)
        "hedgehog"

        # Desktop
        "vulcan"

        # Mini Desktop (Beelink SER7)
        "greenbeen"

        # Media Server (Beelink Mini S12 Pro)
        "jeeves"
      ];
      forEachHost = lib.genAttrs hostnames;
    in
    {
      inherit lib;

      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      overlays = import ./overlays { inherit inputs outputs; };

      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      formatter = forEachSystem (pkgs: pkgs.alejandra);
      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });

      nixosConfigurations = forEachHost (
        host:
        lib.nixosSystem {
          modules = [ ./hosts/${host} ];
          specialArgs = { inherit inputs outputs configRoot; };
        }
      );

      homeConfigurations =
        let
          userHostPairs = lib.cartesianProduct {
            # user = usernames; Audrey's profiles don't use home-manager yet
            user = [ "addison" ];
            host = hostnames;
          };

          homeCfgFor =
            {
              host,
              user,
            }:
            {
              "${user}@${host}" = lib.homeManagerConfiguration {
                modules = [
                  ./home/${user}/${host}.nix
                  ./home/${user}/nixpkgs.nix
                ];
                pkgs = pkgsFor.x86_64-linux;
                extraSpecialArgs = { inherit inputs outputs; };
              };
            };
        in
        lib.mergeAttrsList (map homeCfgFor userHostPairs);
    };
}
