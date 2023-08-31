# lytedev's dotfiles

My various configuration files. I can't recommend using them directly, just
take what you like.

**NOTE**: I'm in the process of migrating/copying some/all things from a wacky
combination of Arch Linux, other Linux distributions, and macOS, to a single
Nix flake for everything. Tread lightly!

## Links

[🖥️ Upstream][upstream] • [🐙 GitHub Mirror][github]

# Basic Setup

For generic dotfiles setup:

```bash
curl -LO lyte.dev/df.sh && sh -i df.sh
```

Or if using the Nix flake (note that this is hostname-dependent):

<!-- TODO: verify this - or update the above method to simply call the following is nixos or home-manager? -->

```bash
sudo nixos-rebuild --flake 'git+https://git.lyte.dev/lytedev/dotfiles?/os/linux/nix#?ref=nix' switch
# or clone
git clone https://git.lyte.dev/lytedev/dotfiles
sudo nixos-rebuild --flake './dotfiles/os/linux/nix#' switch
```

# Screenshots

Any relevant screenshots may be found here:
[files.lyte.dev/images](https://files.lyte.dev/images/)

[upstream]: https://git.lyte.dev/lytedev/dotfiles
[github]: https://github.com/lytedev/dotfiles
[desktop-screenshot]: https://files.lyte.dev/unix/desktop-screenshot.png
[battlestation-photo]: https://files.lyte.dev/unix/battlestation.jpg
