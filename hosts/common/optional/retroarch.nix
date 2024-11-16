{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (retroarch.override {
      cores = with libretro; [
        # Sega
        genesis-plus-gx

        # Sony
        beetle-psx
        beetle-psx-hw

        # Nintendo
        snes9x
        bsnes-mercury-balanced
      ];
    })
  ];
}
