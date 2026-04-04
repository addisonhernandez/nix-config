{
  inputs,
  lib,
  self,
  ...
}:
let
  inherit (inputs) home-manager nixpkgs;
  inherit (self) outputs;

  # A set of instantiated nixpkgs for each supported system.
  #
  # Ex: `self.lib.pkgsFor.x86_64-linux`
  pkgsFor = lib.genAttrs (import inputs.systems) (
    system:
    import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    }
  );

  mkHostConfig =
    host:
    nixpkgs.lib.nixosSystem {
      modules = [ "${self}/hosts/${host}" ];
      # [fixme] bad smell 👃. lean on flake-parts instead.
      specialArgs = { inherit inputs outputs; };
    };

  mkHomeConfig =
    {
      user,
      host,
      system ? "x86_64-linux",
    }:
    {
      "${user}@${host}" = home-manager.lib.homeManagerConfiguration {
        modules = [
          "${self}/home/${user}/${host}.nix"
          "${self}/home/${user}/features/nixpkgs.nix"
        ];
        pkgs = pkgsFor.${system};
        # [fixme] bad smell 👃. lean on flake-parts instead.
        extraSpecialArgs = {
          inherit inputs outputs;
          myHome = {
            hostName = host;
            userHostPair = "${user}@${host}";
          };
        };
      };
    };
in
{
  flake.lib = { inherit pkgsFor mkHomeConfig mkHostConfig; };
}
