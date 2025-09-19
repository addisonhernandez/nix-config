{
  config,
  inputs,
  lib,
  modulesPath,
  pkgs,
  ...
}:
let
  hostName = config.networking.hostName or "nixos";
  rev = inputs.self.shortRev or inputs.self.dirtyShortRev or "dirty";
  name = builtins.concatStringsSep "-" [
    hostName
    config.system.nixos.release
    rev
    pkgs.stdenv.hostPlatform.uname.processor
  ];
in
{
  imports = [ "${modulesPath}/installer/cd-dvd/installation-cd-base.nix" ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
    hostPlatform = "x86_64-linux";
  };

  # Fixes
  system.switch.enable = false;
  security.pam.loginLimits = [
    {
      domain = "*";
      item = "nofile";
      type = "-";
      value = "65535";
    }
  ];
  environment.etc."nix/flake-channels/nixpkgs".source = inputs.nixpkgs;

  # Image customization
  image = {
    baseName = lib.mkImageMediaOverride name;
    extension = lib.mkImageMediaOverride "iso";
  };
  isoImage = {
    volumeID = lib.mkImageMediaOverride name;
    squashfsCompression = "zstd -Xcompression-level 22";
    appendToMenuLabel = "";
    contents = [
      {
        # Rather than pulling from git, `cd /flake` and start building
        source = lib.cleanSource inputs.self;
        target = "/flake";
      }
    ];
  };

  # Networking
  systemd.services.sshd.wantedBy = lib.mkForce [ "multi-user.target" ];
  users.users.root.openssh.authorizedKeys.keyFiles =
    inputs.secrets.pubKeys.userPubKeys;

  # Nix
  nix = {
    package = pkgs.lixPackageSets.latest.lix;
    channel.enable = false;
    settings = {
      auto-optimise-store = false;
      experimental-features = [
        "flakes"
        "nix-command"
        "pipe-operator"
      ];
      extra-substituters = [ "https://nix-community.cachix.org" ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      flake-registry = "";
      http-connections = 50;
      keep-going = true;
      log-lines = 50;
      warn-dirty = false;
    };
  };

  # Programs
  programs.git.package = pkgs.gitMinimal;

  # Space savings
  documentation = {
    enable = lib.mkForce false;
    dev.enable = lib.mkForce false;
    doc.enable = lib.mkForce false;
    info.enable = lib.mkForce false;
    man.enable = lib.mkForce false;
    man.man-db.enable = lib.mkForce false;
    nixos.enable = lib.mkForce false;
  };
  system.installer.channel.enable = false;
}
