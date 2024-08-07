{
  imports = [];

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        options = "caps:escape_shifted_capslock";
      };
    };

    flatpak.enable = true;

    devmon.enable = true;
    udisks2.enable = true;

    printing.enable = true;

    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  };

  console.useXkbConfig = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
