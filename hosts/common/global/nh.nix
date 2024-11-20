{outputs, ...}: {
  programs.nh = {
    enable = true;
    flake = outputs.configRoot;
  };
}
