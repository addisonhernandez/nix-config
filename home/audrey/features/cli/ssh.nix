{
  programs.ssh = {
    enable = true;

    matchBlocks."*" = {
      # Settings formerly set by `programs.ssh.enableDefaultConfig`
      addKeysToAgent = "no";
      compression = false;
      controlMaster = "no";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "no";
      forwardAgent = false;
      hashKnownHosts = false;
      serverAliveCountMax = 3;
      serverAliveInterval = 0;
      userKnownHostsFile = "~/.ssh/known_hosts";
    };
  };
}
