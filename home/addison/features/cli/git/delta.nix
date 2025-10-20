{ config, ... }:
{
  programs.delta = {
    enable = true;
    enableGitIntegration = config.programs.git.enable;
    options.navigate = "true";
  };

  catppuccin.delta.enable = true;
}
