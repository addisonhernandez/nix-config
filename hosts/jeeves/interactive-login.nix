{
  config,
  lib,
  pkgs,
  ...
}:
let
  pam_succeed_if = "${pkgs.linux-pam}/lib/security/pam_succeed_if.so";
  pam_kwallet = "${pkgs.kdePackages.kwallet-pam}/lib/security/pam_kwallet.so";
in
{
  security.pam.services = {
    sddm.text = lib.mkBefore ''
      # passwordless interactive login
      auth      sufficient    ${pam_succeed_if} user ingroup nopasswdlogin

      # Unlock kwallet
      auth      optional      ${pam_kwallet}
      session   optional      ${pam_kwallet} auto_start
    '';

    # To also allow passwordless login from the KDE lock screen
    # kde.text = lib.mkBefore "auth  sufficient  ${pam_succeed_if} user ingroup nopasswdlogin";

    # Unlock KDE wallet even for tty sessions
    login.kwallet.forceRun = true;
  };

  users.groups.nopasswdlogin.members = with config.users.users; [
    addison.name
    audrey.name
  ];
}
