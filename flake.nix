{
  description = "NixOS and Home Manager Config Entrypoint";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

    # systems.url = "github:nix-systems/default-linux"; # x86_64, aarch64
    systems.url = "github:nix-systems/x86_64-linux";
    hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
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
  in {
    # FIXME: is this needed?
    inherit lib;

    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    overlays = import ./overlays {inherit inputs outputs;};

    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
    formatter = forEachSystem (pkgs: pkgs.alejandra);
    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});

    nixosConfigurations = {
      # Laptop (Dell XPS 9560)
      # hedgehog = lib.nixosSystem {
      #   modules = [./hosts/hedgehog];
      #   specialArgs = {inherit inputs outputs;};
      # };

      # Desktop
      vulcan = lib.nixosSystem {
        modules = [./hosts/vulcan];
        specialArgs = {inherit inputs outputs;};
      };

      # Mini Desktop (Beelink SER7)
      # simple-green = lib.nixosSystem {
      #   modules = [./hosts/simple-green];
      #   specialArgs = {inherit inputs outputs;};
      # };

      # Media Server (Beelink Mini S12 Pro)
      jeeves = lib.nixosSystem {
        modules = [./hosts/jeeves];
        specialArgs = {inherit inputs outputs;};
      };
    };

    homeConfigurations = {
      # Laptop
      # "addison@hedgehog" = lib.homeManagerConfiguration {
      #   modules = [./home/addison/hedgehog.nix ./home/addison/nixpkgs.nix];
      #   pkgs = pkgsFor.x86_64-linux;
      #   extraSpecialArgs = {inherit inputs outputs;};
      # };

      # Desktop
      "addison@vulcan" = lib.homeManagerConfiguration {
        modules = [./home/addison/vulcan.nix ./home/addison/nixpkgs.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };

      # Mini Desktop
      # "addison@simple-green" = lib.homeManagerConfiguration {
      #   modules = [./home/addison/simple-green.nix ./home/addison/nixpkgs.nix];
      #   pkgs = pkgsFor.x86_64-linux;
      #   extraSpecialArgs = {inherit inputs outputs;};
      # };

      # Media Server
      "addison@jeeves" = lib.homeManagerConfiguration {
        modules = [./home/addison/jeeves.nix ./home/addison/nixpkgs.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };
    };
  };
}
