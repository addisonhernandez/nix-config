let
  version = "d960f3f22bd55ebcbb274097444cf74b6493f476"; # commit hash
  sha256 = "sha256-q6tHxhHAh+GuaPaB2IvfeywCrzdCgJMLuRHIPGFaDg8=";
  vendorHash = "sha256-XqtsUIHql3Az+5H2tKP6bksDgpPDTb8Tvr8afMAEXng=";

  mmt =
    {
      buildGoModule,
      fetchFromGitHub,
      lib,
    }:
    buildGoModule {
      inherit version vendorHash;
      name = "mmt-unstable-2026-08-23";
      pname = "mmt";
      src = fetchFromGitHub {
        inherit sha256;
        owner = "konradit";
        repo = "mmt";
        rev = version;
      };

      checkFlags = [
        # `TestParseSRT` & `TestParseGPMF` failures from fragile upstream config
        "-skip=^TestParse(SRT|GPMF)$"
      ];

      meta = {
        description = lib.concatStringsSep " - " [
          "Media Management Tool"
          "make importing media from GoPro and other action cameras more bearable"
        ];
        homepage = "https://github.com/konradit/mmt";
        license = [ lib.licenses.asl20 ];
        mainProgram = "mmt";
      };
    };
in
{
  perSystem =
    { pkgs, ... }:
    {
      packages.mmt = pkgs.callPackage mmt { };
    };
}
