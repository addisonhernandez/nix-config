{
  pkgs ? import <nixpkgs> {
    config = { };
    overlays = [ ];
  },
  ...
}:
{
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes ca-derivations";
    nativeBuildInputs = with pkgs; [
      nix
      home-manager
      git
    ];
    packages = with pkgs; [
      nodePackages.prettier
      stylua
      yaml-language-server
    ];
  };
}
