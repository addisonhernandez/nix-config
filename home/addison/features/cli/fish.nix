{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      if command -q zoxide
        zoxide init fish | source
      end
    '';

    functions = {
      fish_greeting = "";
    };
  };
}
