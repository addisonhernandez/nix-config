# Hardware: (github.com/NixOS/nixos-hardware/tree/master/dell/xps/15-9560)
{ inputs, ... }:
let
  hardwareModules = inputs.nixos-hardware.nixosModules;
in
{
  specialisation = {
    # iGPU only
    intel.configuration = {
      imports = [ hardwareModules.dell-xps-15-9560-intel ];
      system.nixos.tags = [ "iGPU" ];
    };

    # nvidia prime dGPU/iGPU
    nvidia-prime.configuration = {
      imports = [ hardwareModules.dell-xps-15-9560 ];
      system.nixos.tags = [ "nvidia-prime" ];
    };

    # nvidia dGPU only
    # nvidia.configuration = {
    #   imports = [ hardwareModules.dell-xps-15-9560-nvidia ];
    #   system.nixos.tags = [ "nvidia" ];
    # };
  };
}
