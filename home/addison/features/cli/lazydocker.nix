{
  nixosConfig ? { },
  ...
}:
{
  programs.lazydocker = {
    enable = nixosConfig.virtualisation.docker.enable or false;
    # settings = { /* yaml value */ };
  };
}
