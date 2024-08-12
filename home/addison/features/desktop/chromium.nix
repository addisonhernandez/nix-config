{
  programs.chromium = {
    enable = true;
    extensions = [
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
      {id = "nngceckbapebfimnlniiiahkandclblb";} # bitwarden
      {id = "clngdbkpkpeebahjckkjfobafhncgmne";} # stylus
      {id = "fmkadmapgofadopljbjfkapdkoienihi";} # react dev tools
      {id = "jinjaccalgkegednnccohejagnlnfdag";} # violentmonkey
    ];
  };
}
