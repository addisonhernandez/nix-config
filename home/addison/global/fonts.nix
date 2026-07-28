{
  config,
  lib,
  pkgs,
  ...
}:
let
  localFontsDir = "${config.xdg.dataHome}/fonts";
  systemFontsDir = "/run/current-system/sw/share/X11/fonts";

  getCoreExe = lib.getExe' pkgs.coreutils;
  mkLocalFontsDir = pkgs.writeShellScript "make-local-fonts-dir" ''
    [[ -d ${localFontsDir} ]] || ${getCoreExe "mkdir"} -p ${localFontsDir}
  '';
  cpSysFontsToLocal = pkgs.writeShellScript "copy-sys-fonts-to-local" ''
    ${getCoreExe "cp"} --dereference --reflink=always --force ${systemFontsDir}/* ${localFontsDir}
  '';
in
{
  # Fixes flatpak applications unable to access system fonts. See:
  # https://wiki.nixos.org/wiki/Fonts#Flatpak_applications_can't_find_system_fonts
  systemd.user.services.copy-fonts-to-local = {
    Service = {
      Type = "simple";
      ExecStartPre = [ mkLocalFontsDir.outPath ];
      ExecStart = cpSysFontsToLocal.outPath;
    };
    Unit = {
      Description = "Copy system fonts to $HOME/.local/share/fonts for flatpak applications";
      After = [ "default.target" ];
      RequiresMountsFor = systemFontsDir;
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
