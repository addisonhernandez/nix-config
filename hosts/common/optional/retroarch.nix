{ pkgs, ... }:
let
  retroarchWithCores = pkgs.retroarch.withCores (
    cores: with cores; [
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
  );
in
{
  environment.systemPackages = [ retroarchWithCores ];
}
