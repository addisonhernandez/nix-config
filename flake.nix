{
  description = "NixOS and Home Manager Config Entrypoint";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    systems.url = "github:nix-systems/x86_64-linux";
    hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Non-flake inputs
    catppuccin-yazi = {
      url = "github:catppuccin/yazi";
      flake = false;
    };
    catppuccin-delta = {
      url = "github:catppuccin/delta";
      flake = false;
    };
    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    systems,
    ...
  } @ inputs: let
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
  in {
    inherit lib;

    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    overlays = import ./overlays {inherit inputs outputs;};

    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
    formatter = forEachSystem (pkgs: pkgs.alejandra);
    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});

    nixosConfigurations = forEachHost (
      host:
        lib.nixosSystem {
          modules = [./hosts/${host}];
          specialArgs = {inherit inputs outputs configRoot;};
        }
    );

    homeConfigurations = let
      userHostPairs = lib.cartesianProduct {
        # user = usernames; Audrey's profiles don't use home-manager yet
        user = ["addison"];
        host = hostnames;
      };

      homeCfgFor = {
        host,
        user,
      }: {
        "${user}@${host}" = lib.homeManagerConfiguration {
          modules = [./home/${user}/${host}.nix ./home/${user}/nixpkgs.nix];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = {inherit inputs outputs;};
        };
      };
    in
      lib.mergeAttrsList (map homeCfgFor userHostPairs);
  };
}
