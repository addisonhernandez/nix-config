{ inputs, pkgs, ... }:
{
  imports = [
    inputs.hardware.nixosModules.common-gpu-intel
  ];

  hardware.intelgpu.vaapiDriver = "intel-media-driver";
  hardware.intelgpu.enableHybridCodec = true;

  # enable VAAPI and Intel QSV
  # nixpkgs.config.packageOverrides = pkgs: {
  #   vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  # };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      # intel-media-driver
      libva-vdpau-driver
      # intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      # vpl-gpu-rt # QSV on 11th gen or newer
    ];
  };
}
