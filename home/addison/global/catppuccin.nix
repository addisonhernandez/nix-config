{ inputs, ... }:
{
  imports = [ inputs.catppuccin.homeModules.default ];

  catppuccin.flavor = "macchiato";
  catppuccin.accent = "mauve";
}
