{ inputs, pkgs, ... }:
{
  environment.systemPackages = [
    # [todo] migrate to self.packages
    (pkgs.callPackage "${inputs.self}/pkgs/mmt" { })
  ];
}
