{ inputs, ... }:
{
  imports = [ inputs.catppuccin.homeModules.default ];

  catppuccin = {
    autoEnable = false;
    enable = true;

    flavor = "macchiato";
    accent = "mauve";
  };
}
