set lazy
set unstable

local_hostname := `uname -n`
current_branch := `git symbolic-ref --short HEAD`
host_refs := ```
    nix eval .#hostnames --raw --apply '
        hosts:
        hosts
        |> map (host: "${toString ./.}#nixosConfigurations.${host}.config.system.build.toplevel")
        |> builtins.concatStringsSep " "'
    ```

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
dry-activate: sudo
    nixos-rebuild dry-activate \
        --flake .#{{ local_hostname }} \
        --sudo \
        --log-format internal-json \
        |& nom --json

# build the config and link the derivation to ./result
[group('build tools')]
build host=local_hostname *nh_args:
    nh os build --hostname {{ host }} --out-link ./result {{ nh_args }}

# build the local config on a remote host (default greenbeen)
[group('build tools')]
[arg("nh_op", pattern="boot|build|repl|switch|test")]
[arg("build_host", long, short="b")]
remote-op nh_op="build" build_host="greenbeen.lan" *nh_args:
    nh os {{ nh_op }} \
        --hostname {{ local_hostname }} \
        --build-host {{ build_host }} \
        {{ nh_args }}

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
diff-system *diff_args: (build local_hostname "--no-validate" "--diff never")
    @test -r "/nix/var/nix/profiles/system"
    @test -r "./result"
    dix diff {{ diff_args }} -- "/nix/var/nix/profiles/system" "./result"

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
    nh os boot --target-host {{ host }} --ask --use-substitutes {{ nh_args }}

# build the config for a host, then send it via ssh
[group('build tools')]
send-build host *nh_args: (test-store host) (build host nh_args) && rm-build-artifacts
    nix copy \
        --no-check-sigs \
        --to "ssh-ng://{{ host }}.lan" \
        "$(readlink ./result)"

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
    git remote \
        | xargs -I{} -P0 git push {{ git_push_args }} {} {{ current_branch }}
