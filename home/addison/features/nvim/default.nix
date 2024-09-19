{
  config,
  pkgs,
  ...
}: {
  imports = [
    # TODO
    # ./lsp.nix
    # ./syntaxes.nix
    # ./ui.nix
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
    # defaultEditor = true;

    extraPackages = with pkgs; [
      gnumake
      unzip
      libgcc
      gcc_multi

      xclip
      xsel
      wl-clipboard
    ];
  };

  xdg.desktopEntries = {
    nvim = {
      name = "Neovim";
      genericName = "Text Editor";
      comment = "Edit text files";
      exec = "nvim %F";
      icon = "nvim";
      mimeType = [
        "text/english"
        "text/plain"
        "text/x-makefile"
        "text/x-c++hdr"
        "text/x-c++src"
        "text/x-chdr"
        "text/x-csrc"
        "text/x-java"
        "text/x-moc"
        "text/x-pascal"
        "text/x-tcl"
        "text/x-tex"
        "application/x-shellscript"
        "text/x-c"
        "text/x-c++"
      ];
      terminal = true;
      type = "Application";
      categories = [
        "Utility"
        "TextEditor"
      ];
    };
  };
}
