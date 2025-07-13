{ config, outputs, ... }:
let
  inherit (config.myUtils) tailnet;
  mkSubdomainLink = subdomain: "https://${subdomain}.${tailnet.magicDNSSuffix}";
  mkTailnetNode = outputs.lib.mkTailnetNode config;
in
{
  services.homepage-dashboard = {
    enable = true;

    allowedHosts = builtins.concatStringsSep "," (
      [
        "homelab.addisonhernandez.com"
        "jeeves.${tailnet.magicDNSSuffix}"
        "jeeves.${tailnet.magicDNSSuffix}:8082"
      ]
      ++ tailnet.networkMap.homepage.FQDNs
    );

    bookmarks = [
      {
        Dev = [
          {
            "addison on Codeberg" = [
              {
                icon = "sh-codeberg";
                href = "https://codeberg.org/addison";
              }
            ];
          }
          {
            "addisonhernandez on GitHub" = [
              {
                icon = "github";
                href = "https://github.com/addisonhernandez";
              }
            ];
          }
        ];
      }
      {
        Social = [
          {
            "@addisonhernandez.com on Bluesky" = [
              {
                icon = "bluesky";
                href = "https://bsky.app/profile/addisonhernandez.com";
              }
            ];
          }
        ];
      }
    ];

    services = [
      {
        Homelab = [
          {
            Media = [
              {
                Jellyfin = {
                  href = mkSubdomainLink "media";
                  description = "Movies and TV Shows";
                  icon = "jellyfin";
                };
              }
              {
                Audiobookshelf = {
                  href = mkSubdomainLink "audiobooks";
                  description = "Audiobooks";
                  icon = "audiobookshelf";
                };
              }
            ];
          }
          {
            Services = [
              {
                Lubelogger = {
                  href = mkSubdomainLink "lubelogger";
                  description = "Automobile Maintenance Tracker";
                  icon = "lubelogger";
                };
              }
            ];
          }
        ];
      }
      {
        "Media Management" = [
          {
            Jellyseerr = {
              href = mkSubdomainLink "requests";
              description = "Media Acquisition Requests";
              icon = "jellyseerr";
            };
          }
          {
            Radarr = {
              href = mkSubdomainLink "movies";
              description = "Movie Management";
              icon = "radarr";
            };
          }
          {
            Sonarr = {
              href = mkSubdomainLink "shows";
              description = "TV Show Management";
              icon = "sonarr";
            };
          }
          {
            Prowlarr = {
              href = mkSubdomainLink "indexers";
              description = "Torrent Tracker Management";
              icon = "prowlarr";
            };
          }
          {
            qBittorrent = {
              href = mkSubdomainLink "torrents";
              description = "Torrent Management";
              icon = "qbittorrent";
            };
          }
        ];
      }
    ];

    widgets = [
      {
        resources = {
          label = "System";
          cpu = true;
          cputemp = true;
          units = "metric";
          memory = true;
          disk = "/";
          uptime = true;
        };
      }
      {
        resources = {
          label = "Storage";
          disk = "/homelab/data";
          expanded = true;
        };
      }
      {
        search = {
          provider = "custom";
          url = "https://www.startpage.com/sp/search?query=";
          suggestionUrl = "https://www.startpage.com/osuggestions?q=";
          showSuggestions = true;
          target = "_blank";
        };
      }
    ];
  };

  services.caddy.virtualHosts.home = mkTailnetNode "homepage";
}
