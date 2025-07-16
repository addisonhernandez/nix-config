{ inputs, outputs }:
let
  inherit (inputs)
    home-manager
    nixpkgs
    self
    systems
    ;

  lib = nixpkgs.lib // home-manager.lib;

  pkgsFor = lib.genAttrs (import systems) (
    system:
    import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    }
  );
  forEachSystem = f: lib.genAttrs (import systems) (sys: f pkgsFor.${sys});

  mkHostConfig =
    host:
    lib.nixosSystem {
      modules = [ "${self}/hosts/${host}" ];
      specialArgs = { inherit inputs outputs; };
    };
  mkHomeConfig =
    { user, host }:
    {
      "${user}@${host}" = lib.homeManagerConfiguration {
        modules = [
          "${self}/home/${user}/${host}.nix"
          "${self}/home/${user}/features/nixpkgs.nix"
        ];
        pkgs = pkgsFor.x86_64-linux; # FIXME: make this architecture agnostic
        extraSpecialArgs = { inherit inputs outputs; };
      };
    };

  defaultStr = default: maybeStr: if (builtins.toString maybeStr) != "" then maybeStr else default;

  mkTailnetNode =
    config: service:
    let
      inherit (config.myUtils.tailnet) networkMap;
    in
    {
      extraConfig =
        # Caddyfile
        ''
          bind ${networkMap.${service}.bindHosts}
          reverse_proxy :${toString networkMap.${service}.proxiedPort}
        '';
      hostName = builtins.head networkMap.${service}.FQDNs;
      serverAliases = builtins.tail networkMap.${service}.FQDNs;
    };
in
lib
// {
  inherit
    defaultStr
    forEachSystem
    mkHomeConfig
    mkHostConfig
    mkTailnetNode
    ;
}
