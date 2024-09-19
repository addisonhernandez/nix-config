{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      if command -q zoxide
        zoxide init fish | source
      end

      if command -q zellij
        zellij setup --generate-completions fish >/dev/null
      end
    '';

    functions = {
      fish_greeting = "";
    };
  };
}
