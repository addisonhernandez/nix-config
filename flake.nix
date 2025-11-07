{
  description = "NixOS and Home Manager Config Entrypoint";

  inputs = {
    ## Configuration building blocks
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
    { flake-parts, import-tree, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } (import-tree ./modules/flake);
}
