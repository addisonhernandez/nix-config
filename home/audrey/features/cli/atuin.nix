{
  programs.atuin = {
    enable = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      stats.common_subcommands = [
        "apt"
        "bw"
        "cargo"
        "chezmoi"
        "composer"
        "dnf"
        "docker"
        "git"
        "go"
        "ip"
        "kubectl"
        "nix"
        "nmcli"
        "npm"
        "pecl"
        "pnpm"
        "podman"
        "port"
        "systemctl"
        "tmux"
        "yarn"
      ];
      sync.records = true;
    };
  };
}
