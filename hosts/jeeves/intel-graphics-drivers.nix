{ inputs, pkgs, ... }:
{
  imports = [ inputs.nixos-hardware.nixosModules.common-gpu-intel ];

  hardware = {
    intelgpu = {
      vaapiDriver = "intel-media-driver";
      enableHybridCodec = true;
    };
    graphics = {
      enable = true;
      extraPackages = with pkgs; [ libva-vdpau-driver ];
    };
  };
}
