{
  config,
  lib,
  pkgs,
  ...
}:
let
  pam_succeed_if = "${pkgs.linux-pam}/lib/security/pam_succeed_if.so";
  pam_kwallet = "${pkgs.kdePackages.kwallet-pam}/lib/security/pam_kwallet.so";

  pamSettings = ''
    # passwordless interactive login
    auth      sufficient    ${pam_succeed_if} user ingroup nopasswdlogin
    auth       include      system-login
    account    include      system-login
    session    include      system-login
    password   include      system-login

    # Unlock kwallet
    auth      optional      ${pam_kwallet}
    session   optional      ${pam_kwallet} auto_start
  '';
in
{
  security.pam.services = {
    sddm.text = lib.mkBefore pamSettings;
    plasmalogin.text = lib.mkBefore pamSettings;

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
