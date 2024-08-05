{
  enable = true;
  interactiveShellInit = ''
    set --global --export SHELL (command -v fish)

    command -q nvim
    and set --global --export EDITOR (command -v nvim)
    and set --global --export VISUAL (command -v nvim)
  '';
}
