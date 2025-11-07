{ inputs, self, ... }:
let
  inherit (inputs) home-manager nixpkgs;
  inherit (self) outputs;
  inherit (self.lib) pkgsFor;
in
{
  flake.lib = {
    mkHostConfig =
      host:
      nixpkgs.lib.nixosSystem {
        modules = [ "${self}/hosts/${host}" ];
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
          extraSpecialArgs = {
            inherit inputs outputs;
            myHome = {
              hostName = host;
              userHostPair = "${user}@${host}";
            };
          };
        };
      };
  };
}
