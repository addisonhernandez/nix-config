{ inputs, pkgs, ... }:
{
  imports = [ inputs.hardware.nixosModules.common-gpu-intel ];

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
