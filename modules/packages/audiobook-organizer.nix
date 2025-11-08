let
  audiobookOrganizer =
    {
      buildGoModule,
      fetchFromGitHub,
      lib,
    }:
    let
      version = "0.10.1";
      sha256 = "sha256-dRg3hP/QkZCekBeNwcwvGD1sRX79xF7oAQZ127Sjr+Y=";
      vendorHash = "sha256-ZUHq5KbFWODpe4HI2NoGdvDrkZYDM1Hvls2YmP49vso=";
    in
    buildGoModule {
      inherit version vendorHash;
      pname = "audiobook-organizer";
      src = fetchFromGitHub {
        inherit sha256;
        owner = "jeeftor";
        repo = "audiobook-organizer";
        tag = "v${version}";
      };

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
