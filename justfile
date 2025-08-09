hostname := `uname -n`

# list just command runner recipes
default:
    @just --list --unsorted --justfile {{ justfile() }}

# check whether the config flake evaluates
check:
    nix flake check .

# update config flake inputs
update:
    nix flake update
    git add flake.lock

# format nix files with nixfmt
[group('style')]
nixfmt:
    fd --extension "nix" --exec-batch nixfmt --strict {}

# lint nix files with statix
[group('style')]
lint:
    nix run nixpkgs#statix -- check

# use nh to more thoroughly clean the system and store
nh-clean:
    nh clean all --keep 3 --keep-since 14d

# build the config and show what would change
[group('build tools')]
dry-activate host=hostname:
    nixos-rebuild dry-activate --flake .#{{ host }} --sudo

# build the config and link the derivation to ./result
[group('build tools')]
build host=hostname:
    nixos-rebuild build --flake .#{{ host }} --keep-going

# build all hosts
[group('build tools')]
build-all:
    nix eval .#nixosConfigurations --raw --apply '\
        configs: \
        let \
            hostnames = builtins.attrNames configs; \
            mkInstallable = host: "${toString ./.}#nixosConfigurations.${host}.config.system.build.toplevel"; \
        in \
            builtins.concatStringsSep " " (map mkInstallable hostnames)' \
        | nix build --no-link --stdin

# diff the activated system and a freshly built config
[group('build tools')]
diff-system prev="/nix/var/nix/profiles/system" final="./result": build
    @test -r {{ prev }}
    @test -r {{ final }}
    nvd diff {{ prev }} {{ final }}

# build and activate the config, and make it the boot default
[confirm('Build and switch to the new config?')]
[group('build tools')]
rebuild-switch host=hostname: && rm-build-artifacts
    @sudo true
    nixos-rebuild switch --flake .#{{ host }} --sudo

# build the config, and activate it after a reboot
[confirm('Build the new config and activate after reboot?')]
[group('build tools')]
rebuild-boot host=hostname: && rm-build-artifacts
    @sudo true
    nixos-rebuild boot --flake .#{{ host }} --sudo

# build the config and test it in the current session
[confirm('Build new config and test it in this session?')]
[group('build tools')]
rebuild-test host=hostname: && rm-build-artifacts
    @sudo true
    nixos-rebuild test --flake .#{{ host }} --sudo

# Clean leftover nix build artifacts
[group('build tools')]
rm-build-artifacts:
    @fd --no-ignore --type symlink 'result.*' . --exec-batch rm --dir {}

# build the config for a host, then send it via ssh
[group('build tools')]
send-build host: (test-store host)
    nixos-rebuild build --flake .#{{ host }} --target-host {{ host }}.lan
    @rm --dir result

# test connection to a remote nix store
test-store host:
    @nix store ping --store "ssh-ng://{{ host }}.lan" --quiet
