{
  programs.fish = {
    enable = true;

    functions = {
      fish_greeting = "";

      lx = {
        description = "List contents of a directory, including hidden, in long format with classification indicators";
        wraps = "eza";
        body = ''
          eza \
            --all \
            --classify \
            --git \
            --group \
            --group-directories-first \
            --header \
            --icons \
            --long \
            --smart-group \
            --sort=type \
            $argv
        '';
      };

      lt = {
        description = "List files in a tree (two levels deep by default)";
        wraps = "lx";
        body = "lx --tree --level=2 $argv";
      };

      tkdir = {
        description = "Create a new directory and cd into it";
        argumentNames = "dirname";
        body = ''
          set --function dirname (path resolve $dirname)
          mkdir --parents $dirname
          and cd $dirname
        '';
      };

      multicd = "echo cd (string repeat --count (math (string length -- $argv[1]) -1) ../)";
    };

    shellAbbrs = {
      dotdot = {
        regex = "^\\.\\.+$";
        function = "multicd";
      };
      flatsearch = "flatpak search --columns=name:full,description:end,application:full";
    };
  };

  catppuccin.fish.enable = true;
}
