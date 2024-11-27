{configRoot, ...}: {
  programs.nh = {
    enable = true;
    flake = configRoot;
  };
}
