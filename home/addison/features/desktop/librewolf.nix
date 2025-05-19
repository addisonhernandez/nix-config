{
  programs.librewolf = {
    enable = true;

    settings = {
      # Appearance
      "browser.compactmode.show" = true;
      "browser.display.use_system_colors" = true;
      "browser.download.autohideButton" = true;
      "browser.toolbars.bookmarks.visibility" = "newtab";
      "browser.uidensity" = 1; # compact
      "font.default.x-wester" = "sans-serif";
      "font.name.monospace.x-western" = "Maple Mono NF";
      "font.name.sans-serif.x-wester" = "Inter";
      "font.name.serif.x-western" = "Noto Serif";

      # Functionality
      "browser.gesture.swipe.left" = "";
      "browser.gesture.swipe.right" = "";
      "browser.search.openintab" = true;
      "browser.urlbar.suggest.history" = false;
      "middlemouse.paste" = false;
      "widget.use-xdg-desktop-portal.file-picker" = 1;

      # Privacy
      "browser.contentblocking.category" = "strict";
      "browser.ml.enable" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.fingerprintingProtection" = true;
      "privacy.resistFingerprinting.letterboxing" = true;
      "privacy.trackingprotection.emailtracking.enabled" = true;
      "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.socialtracking.enabled" = true;
    };
  };
}
