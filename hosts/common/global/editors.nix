{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    helix
    neovim
  ];
}
