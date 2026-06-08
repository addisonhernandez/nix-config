{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  defaultPrefs =
    lib.mapAttrsToList
      (name: value: "pref(${lib.toJSON name}, ${lib.toJSON value});")
      {
        "browser.backup.location" =
          "${config.home.homeDirectory}/Documents/backup/Zen Browser";
        "browser.gesture.swipe.left" = "";
        "browser.gesture.swipe.right" = "";
        "browser.uidensity" = 1; # 0->Normal 1->Compact 2->Touch
        "browser.urlbar.trimHttps" = false;
        "browser.urlbar.trimURLs" = false;

        "font.default.x-western" = "sans-serif";
        "font.name.monospace.x-western" = "Maple Mono NF";
        "font.name.sans-serif.x-western" = "Inter";
        "font.name.serif.x-western" = "Noto Serif";

        "widget.use-xdg-desktop-portal.file-picker" = 1;

        "zen.tabs.vertical.right-side" = true;
        "zen.theme.accent-color" = "#c6a0f6"; # catppuccin-macchiato mauve
        "zen.view.compact.enable-at-startup" = true;
        "zen.view.compact.hide-tabbar" = true;
        "zen.view.compact.hide-toolbar" = true;
        "zen.view.compact.should-enable-at-startup" = true;
        "zen.view.use-single-toolbar" = false;
      };
  lockedPrefs =
    lib.mapAttrsToList
      (name: value: "lockedPref(${lib.toJSON name}, ${lib.toJSON value});")
      {
        "browser.aboutConfig.showWarning" = false;
        "browser.compactmode.show" = true;
        "browser.ml.enable" = false;
        "browser.ml.chat.enable" = false;
        "browser.ml.pageAssist.enable" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.system.showSponsored" = false;
        "browser.urlbar.sponsoredTopSites" = false;

        "middlemouse.paste" = false;
      };

  defaultExtensions =
    let
      mkExt =
        shortId: guid:
        {
          installation_mode ? "normal_installed", # normal_installed | force_installed
          default_area ? "menupanel", # menupanel | navbar
          private_browsing ? false,
        }:
        {
          name = guid;
          value = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/${shortId}/latest.xpi";
            inherit default_area installation_mode private_browsing;
          };
        };
    in
    [
      (mkExt "ublock-origin" "uBlock0@raymondhill.net" {
        installation_mode = "force_installed";
        default_area = "navbar";
        private_browsing = true;
      })
      (mkExt "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}" {
        installation_mode = "force_installed";
        default_area = "navbar";
        private_browsing = true;
      })
      (mkExt "privacy-badger17" "jid1-MnnxcxisBPnSXQ@jetpack" { })
      (mkExt "sponsorblock" "sponsorBlocker@ajay.app" { })
      (mkExt "styl-us" "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" { })
    ];

  defaultSearchEngines = [
    {
      Name = "DuckDuckGo NoAI";
      URLTemplate = "https://noai.duckduckgo.com/?${
        lib.concatStringsSep "&" [
          # See: https://duckduckgo.com/duckduckgo-help-pages/settings/params
          "k1=-1" # No Advertisements
          "kl=us-en" # Region
          "kp=-2" # No Safe Search
          "q={searchTerms}"
        ]
      }";
      IconURL = "https://duckduckgo.com/favicon.ico";
      Alias = "@ddg";
    }
    {
      Name = "Nix Packages";
      URLTemplate = "https://search.nixos.org/packages?${
        lib.concatStringsSep "&" [
          "channel=unstable"
          "query={searchTerms}"
        ]
      }";
      IconURL = "https://wiki.nixos.org/favicon.ico";
      Alias = "@np";
    }
    {
      Name = "NixOS Options";
      URLTemplate = "https://search.nixos.org/options?${
        lib.concatStringsSep "&" [
          "channel=unstable"
          "query={searchTerms}"
        ]
      }";
      IconURL = "https://wiki.nixos.org/favicon.ico";
      Alias = "@no";
    }
    {
      Name = "NixOS Wiki";
      URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
      IconURL = "https://wiki.nixos.org/favicon.ico";
      Alias = "@nw";
    }
    {
      Name = "Arch Wiki";
      URLTemplate = "https://wiki.archlinux.org/index.php?search={searchTerms}";
      IconURL = "https://wiki.archlinux.org/favicon.ico";
      Alias = "@aw";
    }
  ];
in
{
  home.packages = [
    (pkgs.wrapFirefox
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
      {
        extraPrefs = lib.concatLines (defaultPrefs ++ lockedPrefs);

        extraPolicies = {
          AutofillAddressEnabled = false;
          AutofillCreditCardEnabled = false;
          DisableSetDesktopBackground = true;
          DisableTelemetry = true;
          DontCheckDefaultBrowser = true;
          ExtensionSettings = lib.listToAttrs defaultExtensions;
          HardwareAcceleration = true;
          NoDefaultBookmarks = true;
          OfferToSaveLoginsDefault = false;
          PasswordManagerEnabled = false;
          Permissions = {
            Autoplay = {
              # "allow-audio-video" | "block-audio" | "block-audio-video"
              Default = "block-audio-video";
              Locked = false;
            };
          };
          SearchEngines = {
            Default = "DuckDuckGo NoAI";
            Add = defaultSearchEngines;
            Remove = [
              "Amazon.com"
              "Bing"
              "DuckDuckGo"
              "eBay"
              "Perplexity"
            ];
          };
        };
      }
    )
  ];
}
