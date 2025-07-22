{
  pkgs ? import <nixpkgs> {
    config = { };
    overlays = [ ];
  },
  ...
}:
{
  audiobook-organizer = pkgs.callPackage ./audiobook-organizer { };
  mmt = pkgs.callPackage ./mmt { };
}
