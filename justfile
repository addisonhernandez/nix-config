hostname := `uname -n`
tmpdir := `mktemp --directory`

# list just command runner recipes
default:
    @just --list --justfile {{ justfile() }}

# check whether the config flake evaluates
check:
    nix flake check .

# update config flake inputs
update:
    nix flake update
    git add flake.lock

# build and activate the config, and make it the boot default
[confirm('Build and switch to the new config?')]
rebuild-switch host=hostname:
    sudo nixos-rebuild switch --flake .#{{ host }}

[confirm('Build the new config and activate after reboot?')]
rebuild-boot host=hostname:
    sudo nixos-rebuild boot --flake .#{{ host }}

[confirm('Build new config and test it in this session?')]
rebuild-test host=hostname:
    sudo nixos-rebuild test --flake .#{{ host }}

# build the config and show what would change
dry-activate host=hostname:
    sudo nixos-rebuild dry-activate --flake .#{{ host }}

# build the config and link the derivation to ./result
build host=hostname:
    nixos-rebuild build --flake .#{{ host }}

# diff the activated system and the system built in ./result
diff-system prev="/nix/var/nix/profiles/system" final="./result": build
    nvd diff {{ prev }} {{ final }}

collect-garbage:
    nix-collect-garbage 2>./gc.log &
