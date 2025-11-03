{ inputs, ... }:
{
  # Systems for which flake-parts builds the perSystem attributes
  systems = import inputs.systems;
}
