{
  buildGoModule,
  fetchFromGitHub,
  lib,
}:
let
  version = "0.9.17";
  sha256 = "03xd6s1cjli81hw0bxbaqipkmsqk90nan4909m0mi3868wq6799v";
  vendorHash = "sha256-zUaRiQKmYPOhCppBQUwlohXpQmpNGwpKcriEwAmM9Sw=";
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
}
