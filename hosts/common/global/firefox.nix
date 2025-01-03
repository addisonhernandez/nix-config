{
  programs.firefox = {
    enable = true;

    # See: https://mozilla.github.io/policy-templates/
    policies = {
      DisableFeedbackCommands = true;
      DisableFirefoxScreenshots = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableSetDesktopBackground = true;
      DisableTelemetry = true;
      NoDefaultBookmarks = true;

      FirefoxHome = {
        Pocket = false;
        SponsoredPocket = false;
        SponsoredTopSites = false;
      };
      FirefoxSuggest = {
        SponsoredSuggestions = false;
      };

      ExtensionSettings = {
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          default_area = "navbar";
        };
        # Bitwarden Password Manager
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          default_area = "navbar";
        };
        # Auto Tab Discard
        "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/auto-tab-discard/latest.xpi";
          default_area = "menupanel";
        };
      };

      Preferences =
        let
          locked-false = {
            Value = false;
            Status = "locked";
          };
          locked-true = {
            Value = true;
            Status = "locked";
          };
          locked-empty = {
            Value = "";
            Status = "locked";
          };
        in
        {
          "extensions.pocket.enabled" = locked-false;
          "browser.ml.enable" = locked-false;
          "browser.ml.chat.enabled" = locked-false;
          "browser.ml.chat.provider" = locked-empty;
          "browser.newtabpage.activity-stream.showSponsored" = locked-false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = locked-false;
        };
    };

    preferencesStatus = "default";
    preferences = {
      "browser.aboutConfig.showWarning" = false;
      "browser.compactmode.show" = true;
      "browser.contentblocking.category" = "strict";
      "browser.gesture.swipe.left" = "";
      "browser.gesture.swipe.right" = "";
      "browser.search.openintab" = true;
      "browser.uidensity" = 1; # compact density

      "extensions.formautofill.addresses.enabled" = false;
      "extensions.formautofill.creditCards.enabled" = false;
    };
  };
}
