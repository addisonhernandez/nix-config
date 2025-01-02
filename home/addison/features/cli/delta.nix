{ ... }:
{
  programs.git.delta = {
    enable = true;
    options.navigate = "true";
  };

  catppuccin.delta.enable = true;
}
