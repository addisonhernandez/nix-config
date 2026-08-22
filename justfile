set lazy
set unstable

hostname := `uname -n`
current_branch := `git symbolic-ref --short HEAD`
host_refs := ```
    nix eval .#hostnames --raw --apply '
        hosts:
        hosts
        |> map (host: "${toString ./.}#nixosConfigurations.${host}.config.system.build.toplevel")
        |> builtins.concatStringsSep " "'
    ```

build_outpath(host) := shell('nix eval --raw .#nixosConfigurations.$1.config.system.build.toplevel.outPath', host)

# list just command runner recipes
default:
    @just --list --unsorted --justfile {{ justfile() }}

# validate sudo privileges
[private]
sudo:
    @sudo -v

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
    nix run github:Mic92/nixfmt-rs -- --strict --width=80 ./

# lint nix files with statix
[group('style')]
lint:
    nix run nixpkgs#statix -- check

# use nh to more thoroughly clean the system and store
nh-clean:
    nh clean all --keep 3 --keep-since 14d

# build the config and show what would change
[group('build tools')]
dry-activate host=hostname: sudo
    nixos-rebuild dry-activate \
        --flake .#{{ host }} \
        --sudo \
        --log-format internal-json \
        |& nom --json

# build the config and link the derivation to ./result
[group('build tools')]
build host=hostname *nh_args:
    nh os build --hostname {{ host }} --out-link ./result {{ nh_args }}

# build the local config on a remote host (default greenbeen)
[group('build tools')]
remote-build build_host="greenbeen.lan": (build hostname "--build-host" build_host)

# build all host configurations
[group('build tools')]
build-all:
    nix build \
        --no-link \
        --log-format internal-json \
        {{ host_refs }} \
        |& nom --json

# diff the activated system and a freshly built config
[group('build tools')]
diff-system *diff_args: (build hostname "--no-validate" "--diff never")
    @test -r "/nix/var/nix/profiles/system"
    @test -r "./result"
    dix {{ diff_args }} -- "/nix/var/nix/profiles/system" "./result"

# build and activate the config, and make it the boot default
[confirm('Build and switch to the new config?')]
[group('build tools')]
rebuild-switch *nh_args: sudo && rm-build-artifacts
    nh os switch --ask {{ nh_args }}

# build the config, and activate it after a reboot
[confirm('Build the new config and activate after reboot?')]
[group('build tools')]
rebuild-boot *nh_args: sudo && rm-build-artifacts
    nh os boot --ask {{ nh_args }}

# deploy the config to a remote machine
[confirm('Build the config for ' + host + ' and activate after reboot?')]
[group('build tools')]
deploy host *nh_args:
    nh os boot --target-host {{ host }} --ask {{ nh_args }}

# build the config for a host, then send it via ssh
[group('build tools')]
send-build host *nh_args: (test-store host) && rm-build-artifacts
    nh os build --target-host {{ host }} {{ nh_args }}

# build the config and test it in the current session
[confirm('Build new config and test it in this session?')]
[group('build tools')]
rebuild-test *nh_args: sudo && rm-build-artifacts
    nh os test --ask {{ nh_args }}

# Clean leftover nix build artifacts
[group('build tools')]
rm-build-artifacts:
    @fd --no-ignore --type symlink 'result.*' . --exec-batch rm --dir {}

# test connection to a remote nix store
test-store host:
    @nix store ping --store "ssh-ng://{{ host }}.lan" --quiet

# push the current branch to all remotes
[group('version control')]
push *git_push_args:
    git remote | xargs -I{} -P0 git push {{ git_push_args }} {} {{ current_branch }}
