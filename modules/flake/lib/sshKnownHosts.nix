{
  config,
  lib,
  self,
  ...
}:
let
  forEachHost = lib.genAttrs (
    builtins.attrNames self.outputs.nixosConfigurations
  );
in
{
  flake.lib = {
    # Convenience mapping of hosts to host names and pub keys.
    ssh.knownHosts = forEachHost (
      hostName:
      let
        publicKeyFile = "${self.inputs.secrets}/hosts/public_keys/host_${hostName}_ed25519.pub";
      in
      lib.mkIf (builtins.pathExists publicKeyFile) {
        inherit publicKeyFile;
        hostNames = [
          hostName
          "${hostName}.lan"
          "${hostName}.${self.lib.tailnet.magicDNSSuffix}"
        ];
      }
    );
  };
}
