{ inputs, outputs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.default ];

  home-manager = {
    backupFileExtension = "bak";
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs outputs; };
  };
}
