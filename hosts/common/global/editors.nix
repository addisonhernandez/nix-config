{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    helix
    lunarvim
    neovim
  ];
}
