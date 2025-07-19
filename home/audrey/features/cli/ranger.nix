{
  programs.ranger = {
    enable = true;
    extraConfig =
      # conf
      ''
        # Colorscheme (one of: default, jungle, snow, solarized)
        # set colorscheme solarized

        # Display status of items under version control
        set vcs_aware true

        # Preview images
        set preview_images true
        set preview_images_method kitty

        # Show line numbers in the main column (one of: false, absolute, relative)
        set line_numbers false

        # If line_numbers is relative, show the absolute value of the current line
        set relative_current_zero true
      '';
  };
}
