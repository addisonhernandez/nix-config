{
  pkgs ?
    import <nixpkgs> {
      config = {};
      overlays = [];
    },
  ...
}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes ca-derivations repl-flake";
    nativeBuildInputs = with pkgs; [
      nix
      home-manager
      git
    ];
  };
}
