{
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.options = "caps:escape_shifted_capslock";
  };

  # Use xkb.options for virtual console
  console.useXkbConfig = true;
}
