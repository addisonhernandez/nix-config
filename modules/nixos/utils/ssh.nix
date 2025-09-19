{
  config,
  inputs,
  lib,
  outputs,
  ...
}:
let
  inherit (lib) types;

  forEachHost = lib.genAttrs (builtins.attrNames outputs.nixosConfigurations);

  knownHostsType.options = {
    hostNames = lib.mkOption { type = types.listOf types.str; };
    publicKeyFile = lib.mkOption { type = types.path; };
  };
in
{
  options.myUtils.ssh = {
    knownHosts = lib.mkOption {
      type = types.attrsOf (types.submodule knownHostsType);
      description = "Default SSH known hosts";
      default = forEachHost (
        hostName:
        lib.mkIf
          (builtins.pathExists "${inputs.secrets}/hosts/public_keys/host_${hostName}_ed25519.pub")
          {
            hostNames = [
              hostName
              "${hostName}.lan"
              "${hostName}.${config.myUtils.tailnet.magicDNSSuffix}"
            ];
            publicKeyFile = "${inputs.secrets}/hosts/public_keys/host_${hostName}_ed25519.pub";
          }
      );
    };
  };
}
