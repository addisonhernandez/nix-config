{
  programs.firefox = {
    enable = true;
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
