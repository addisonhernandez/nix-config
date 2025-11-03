{
  perSystem =
    { config, pkgs, ... }:
    {
      # Enter with `nix develop`.
      # Additional shells can be added with `devShells.<name>` attributes, and
      # can be entered with `nix develop <name>`.
      devShells.default = pkgs.mkShellNoCC {
        name = "config-shell";
        meta.description = "Batteries-included shell for my nix config";

        packages = builtins.attrValues {
          inherit (pkgs)
            # Config management utilities
            age
            gitMinimal
            home-manager
            just
            nh
            sops

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
            ;

          # Alternate nix implementation with convenience features
          inherit (pkgs.lixPackageSets.latest) lix;

          # treefmt defined in modules/flake/formatter.nix
          inherit (config) formatter;
        };

        inputsFrom = [ config.formatter ];

        # Environment variables
        NH_FLAKE = ./.;
        NIXPKGS_ALLOW_UNFREE = 1;
        NIX_CONFIG = "extra-experimental-features = ${
          builtins.concatStringsSep " " [
            "auto-allocate-uids"
            "cgroups"
            "flakes"
            "nix-command"
            "pipe-operator"
          ]
        }";
      };
    };
}
