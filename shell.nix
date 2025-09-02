{
  pkgs ?
    let
      lockFile = builtins.fromJSON (builtins.readFile ./flake.lock);
      nixpkgsChannel =
        if lockFile.nodes ? nixpkgs then
          "nixpkgs"
        else if lockFile.nodes.root.inputs ? nixpkgs then
          # Get the value of the flake option `inputs.nixpkgs.follows`
          builtins.head lockFile.nodes.root.inputs.nixpkgs
        else
          throw "unable to find nixpkgs channel in flake.lock";

      inherit (lockFile.nodes.${nixpkgsChannel}) locked;

      nixpkgs = fetchTarball {
        url = "https://github.com/nixos/nixpkgs/archive/${locked.rev}.tar.gz";
        sha256 = locked.narHash;
      };
    in
    import nixpkgs {
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
      overlays = [ ];
    },
  ...
}:
{
  default = pkgs.mkShellNoCC {
    packages = with pkgs; [
      # Configuration management utilities
      age
      gitMinimal
      home-manager
      just
      lixPackageSets.latest.lix
      nh

      # LSPs and formatters
      lua-language-server
      marksman # md
      nil
      nixd
      prettier # json md yaml
      stylua
      taplo # toml
      tombi # toml
      yaml-language-server
    ];

    # Environment variables
    NH_FLAKE = "/home/addison/.config/nix-config";
    NIXPKGS_ALLOW_UNFREE = 1;
    NIX_CONFIG = "extra-experimental-features = ${
      builtins.concatStringsSep " " [
        "auto-allocate-uids"
        "cgroups"
        "flakes"
        "lix-custom-sub-commands"
        "nix-command"
        "no-url-literals"
        "pipe-operator"
      ]
    }";
  };
}
