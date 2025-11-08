# This file creates a compatibility layer so that `nix-shell` can be used to
# enter the devShells defined by my flake config.
# The devShells definitions can be found in ./modules/flake/devShells.nix
let
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);
  nodeName = lock.nodes.root.inputs.flake-compat;
  flake-compat = fetchTarball {
    url =
      lock.nodes.${nodeName}.locked.url
        or "https://github.com/edolstra/flake-compat/archive/${
          lock.nodes.${nodeName}.locked.rev
        }.tar.gz";
    sha256 = lock.nodes.${nodeName}.locked.narHash;
  };
in
(import flake-compat { src = ./.; }).shellNix
