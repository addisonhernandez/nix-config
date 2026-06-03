{ inputs, ... }:
{
  imports = [ inputs.catppuccin.nixosModules.default ];

  catppuccin = {
    autoEnable = false;
    enable = true;

    flavor = "macchiato";
    accent = "mauve";
    cache.enable = true;
  };
}
