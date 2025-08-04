let
  # [todo] use a snippet in @/modules/home-manager to abstract this
  nixosHostNames =
    builtins.concatMap
      (host: [
        host
        "${host}.lan"
        "${host}.beefalo-spica.ts.net"
      ])
      [
        "greenbeen"
        "hedgehog"
        "jeeves"
        "vulcan"
      ];
in
{
  programs.ssh = {
    enable = true;

    addKeysToAgent = "yes";

    matchBlocks = {
      "codeberg.org" = {
        user = "git";
        identityFile = "~/.ssh/codeberg";
      };
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/github";
      };
      "${builtins.concatStringsSep " " nixosHostNames}" = {
        forwardX11 = true;
        setEnv.COLORTERM = "truecolor";
      };
    };
  };
}
