{
  self,
  config,
  lib,
  ...
}:
let
  inherit (lib) types;
in
{
  options.myUtils.ssh.knownHosts = lib.mkOption {
    type = types.attrsOf (
      types.submodule {
        options = {
          hostNames = lib.mkOption { type = types.listOf types.str; };
          publicKeyFile = lib.mkOption { type = lib.types.path; };
        };
      }
    );
    description = "Default SSH known hosts";

    default = lib.genAttrs [ "greenbeen" "hedgehog" "jeeves" "vulcan" ] (hostName: {
      hostNames = [
        hostName
        "${hostName}.lan"
        "${hostName}.${config.myUtils.tailnet.magicDNSSuffix}"
      ];
      publicKeyFile = "${self.inputs.secrets}/ssh/${hostName}_ed25519_host_key.pub";
    });
  };
}
