let
  version = "0.13.2";
  sha256 = "sha256-2X/cgq1A7hUSRxihoIH0Z0Juc2K0qHeqTie/xKW8f+g=";
  vendorHash = "sha256-AYeqs+VWjJDrV0osqupc+jTnPblt6H60PjjyQEVn2kE=";

  audiobookOrganizer =
    {
      buildGoModule,
      fetchFromGitHub,
      lib,
      gitMinimal,
    }:
    buildGoModule {
      inherit version vendorHash;
      pname = "audiobook-organizer";
      src = fetchFromGitHub {
        inherit sha256;
        owner = "jeeftor";
        repo = "audiobook-organizer";
        tag = "v${version}";
      };

      nativeBuildInputs = [
        # dependency for beta test script
        gitMinimal
      ];

      meta = {
        description = "CLI tool to organize audiobooks for audiobookshelf";
        homepage = "https://github.com/jeeftor/audiobook-organizer";
        changelog = "https://github.com/jeeftor/audiobook-organizer/releases/tag/v${version}";
        license = [ lib.licenses.mit ];
        mainProgram = "audiobook-organizer";
      };
    };
in
{
  perSystem =
    { pkgs, ... }:
    {
      packages.audiobook-organizer = pkgs.callPackage audiobookOrganizer { };
    };
}
