{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set --global --export SHELL (command -v fish)

      command -q nvim
      and set --global --export EDITOR (command -v nvim)
      and set --global --export VISUAL (command -v nvim)

      if command -q zoxide
        zoxide init fish | source
      end
    '';
    functions = {
      fish_greeting = "";
    };
  };
}
