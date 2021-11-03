# lytedev's dotfiles

My various configuration files. I can't recommend using them directly, just
take what you like.

[🖥️ Upstream][upstream] • [🐙 GitHub Mirror][github]

![Battlestation][battlestation-photo]
![Desktop Screenshot][desktop-screenshot]

# Basic Setup

    curl -Ss https://lyte.dev/df.sh | sh

## I don't like `curl ... | sh`

Clone the repo:

    git clone https://git.lyte.dev/lytedev/dotfiles.git "$HOME/.config/lytedev-dotfiles"

Inspect and run the common (no macOS- or Linux-specific configuration) setup
`fish` script:

    $EDITOR "$HOME/.config/lytedev-dotfiles/common/bin/dotfiles-setup"
    "$HOME/.config/lytedev-dotfiles/common/bin/dotfiles-setup"

## Advanced Setup

You will want to symlink relevant environment layers into the `$ENV_PATH` in
order to have your OS-specific applications be configured and common
applications configured for the host OS.

There's a handy `fzf`-based script that makes this super easy:

    dotfiles-link-environments # note that you can select multiple with TAB

You can also list the possible environments:

    cat $DOTFILES_PATH/common/envs

And then link them yourself (note the replacing of slashes with dashes):

    ln -s (pwd)/os/linux $ENV_PATH/os-linux
    ln -s (pwd)/os/linux/arch $ENV_PATH/os-linux-arch
    ln -s (pwd)/host/laptop $ENV_PATH/host-laptop
    ln -s (pwd)/host/laptop/third $ENV_PATH/os-laptop-third
    # etc...

And run setup again once you've finished linking all related environments:

    dotfiles-setup

# To Do

- Home DNS/Wireguard VPN?
- Layered gitconfig?
- Get out of Google!
  - `calcurse` for Calendar management?
  - `aerc` or `neomutt` for email?
  - My home-grown backup network for Drive?
  - Photos?
- **Learn to use `journalctl`**
- Neovim LSP
- Move to NixOS or Guix? Declarative may be the future...?
- Better/more secure remote management configuration?
  - Why can't I hold all these SSH keys/configs/target hosts?
- Setup network file share that's easily accessible from Windows and macOS hosts?
  - Samba?
- Add vim in the terminal as the handler for many MIME types (xdg-open and such)
  for the rare time I'm in a file manager or for opening easily from
  the browser.
  - This goes for navigating "into" a file in `nnn`
- Investigate systemd services that may help with various tasks (homed, etc.)

[upstream]: https://git.faceless.lytedev.io/lytedev/dotfiles
[github]: https://github.com/lytedev/dotfiles
[desktop-screenshot]: https://files.lyte.dev/unix/desktop-screenshot.png
[battlestation-photo]: https://files.lyte.dev/unix/battlestation.jpg
