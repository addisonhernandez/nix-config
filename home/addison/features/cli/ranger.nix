{
  programs.ranger = {
    enable = true;
    settings = {
      # colorscheme = "solarized"; # default | jungle | snow | solarized

      # Display status of items under version control
      vcs_aware = true;

      # Preview images
      preview_images = true;
      preview_images_method = "kitty";

      # Show line numbers in the main column (one of: false, absolute, relative)
      line_numbers = false;

      # If line_numbers is relative, show the absolute value of the current line
      relative_current_zero = true;
    };
  };
}
