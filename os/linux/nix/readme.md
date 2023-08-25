# zomg nixos

```bash
$ ssh -t beefcake 'cdd && pwd && g pl && cd os/linux/nix && sudo nixos-rebuild switch --flake .# && echo DONE'
```

Or for pushing:

```bash
# do once to setup
$ ssh -t beefcake 'cdd && git config receive.denyCurrentBranch updateInstead'

# probably regenerate and commit flake.lock from this directory
nix flake lock

# push and rebuild+switch
$ git push beefcake:~/.config/lytedev-dotfiles
$ ssh -t beefcake 'cd ~/.config/lytedev-dotfiles/os/linux/nix && sudo nixos-rebuild switch --flake .# && echo DONE'
```

# Ops stuff

- **TODO**: Look into https://github.com/zhaofengli/colmena

# Other To Dos

- **TODO**: check stuff during receive with a hook?
