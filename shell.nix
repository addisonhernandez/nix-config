{
  pkgs ? import <nixpkgs> {
    config = { };
    overlays = [ ];
  },
  ...
}:
{
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
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

    shellHook =
      # bash
      ''
        export NH_FLAKE=/home/addison/.config/nix-config
        export NH_OS_FLAKE="$NH_FLAKE#$(hostname)"
      '';
  };
}
