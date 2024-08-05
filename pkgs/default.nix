{
  pkgs ?
    import <nixpkgs> {
      config = {};
      overlays = [];
    },
  ...
}: {
  # TODO: packages here
  # based on https://github.com/Misterio77/nix-config/blob/main/pkgs/default.nix
}
