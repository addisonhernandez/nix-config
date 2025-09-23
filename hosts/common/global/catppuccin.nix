{ inputs, ... }:
{
  imports = [ inputs.catppuccin.nixosModules.default ];

  catppuccin = {
    flavor = "macchiato";
    accent = "mauve";
    cache.enable = true;
  };
}
