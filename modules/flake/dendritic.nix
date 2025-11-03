# Enable the dendritic configuration pattern
#
# In this context, <class> refers to the `class` parameter passed to the nixpkgs
# `lib.evalModules` function.
# See: https://nixos.org/manual/nixpkgs/stable/index.html#module-system-lib-evalModules-param-class
#
# In my config, <class> will be one of [ nixos homeManager ].
# Other common <class> values include [ darwin wsl ].
#
# <aspect> refers to a particular feature or set of closely-related features.
# SSH could be an aspect, which when configured for the nixos class sets up the
# server-side concerns for sshd, and when configured for the homeManager class
# sets up a user's ssh preferences.
{ inputs, ... }:
{
  imports = [
    # enable `flake.modules.<class>.<aspect>` construction
    inputs.flake-parts.flakeModules.modules

    # enable `flake.aspects.<aspect>.<class>` transposition
    inputs.flake-aspects.flakeModule
  ];
}
