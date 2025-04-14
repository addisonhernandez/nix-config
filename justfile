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
nixfmt:
    fd --extension "nix" --exec-batch nixfmt --strict {}

# lint nix files with statix
lint:
    nix run nixpkgs#statix -- check

# use nh to more thoroughly clean the system and store
nh-clean:
    nh clean all --keep 3 --keep-since 14d

# build the config and show what would change
dry-activate host=hostname:
    nixos-rebuild dry-activate --flake .#{{ host }} --use-remote-sudo

# build the config and link the derivation to ./result
build host=hostname:
    nixos-rebuild build --flake .#{{ host }} --keep-going

# diff the activated system and a freshly built config
diff-system prev="/nix/var/nix/profiles/system" final="./result": build
    nvd diff {{ prev }} {{ final }}

# build and activate the config, and make it the boot default
[confirm('Build and switch to the new config?')]
rebuild-switch host=hostname:
    @sudo true
    nixos-rebuild switch --flake .#{{ host }} --use-remote-sudo

# build the config, and activate it after a reboot
[confirm('Build the new config and activate after reboot?')]
rebuild-boot host=hostname:
    @sudo true
    nixos-rebuild boot --flake .#{{ host }} --use-remote-sudo

# build the config and test it in the current session
[confirm('Build new config and test it in this session?')]
rebuild-test host=hostname:
    @sudo true
    nixos-rebuild test --flake .#{{ host }} --use-remote-sudo

# build the config for a host, then send it via ssh
send-build host: (build host)
    @nix store info --store "ssh-ng://{{ host }}.lan" --quiet
    nix copy --no-check-sigs --to "ssh-ng://{{ host }}.lan" ./result
    @rm --dir result
