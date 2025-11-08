let
  mmt =
    {
      buildGoModule,
      fetchFromGitHub,
      lib,
    }:
    let
      version = "2.0";
      sha256 = "sha256-Se5mVj2+QWggaoScfLTLb3sRCI/mDAWYZX/5WTn9syQ=";
      vendorHash = "sha256-obrRLICBpI8dxojaHm3SY+B2sBSTbq/dteUvTNTtwpE=";
    in
    buildGoModule {
      inherit version vendorHash;
      pname = "mmt";
      src = fetchFromGitHub {
        inherit sha256;
        owner = "konradit";
        repo = "mmt";
        rev = "v${version}";
      };

      checkFlags = [
        # `TestParseSRT` & `TestParseGPMF` failures from fragile upstream config
        "-skip=^TestParse(SRT|GPMF)$"
      ];

      meta = {
        description = lib.concatStringsSep " - " [
          "Media Management Tool"
          "make importing media from GoPro and other action cameras a little bit more bearable"
        ];
        homepage = "https://github.com/konradit/mmt";
        changelog = "https://github.com/konradit/mmt/releases/tag/v${version}";
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
