{ config, ... }:
{
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    policies = {
      "DisablePocket" = true;
      "DisableTelemetry" = true;
      "FirefoxHome" = {
        "SponsoredTopSites" = false;
        "Pocket" = false;
        "SponsoredPocket" = false;
      };
      "FirefoxSuggest" = {
        "SponsoredSuggestions" = false;
      };
    };
  };
}
