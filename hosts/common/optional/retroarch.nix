{ pkgs, ... }:
{
  environment.systemPackages = [
    (pkgs.retroarch.withCores (
      corePkgs: with corePkgs; [
        # Sega
        genesis-plus-gx

        # Sony
        beetle-psx
        beetle-psx-hw
        pcsx2
        play

        # Nintendo
        snes9x
        bsnes-mercury-balanced
      ]
    ))
  ];
}
