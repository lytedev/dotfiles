# lytedev's dotfiles

My various configuration files. Don't use them directly, just take what you
like.

[🖥️ Upstream][upstream] • [🐙 GitHub Mirror][github]

![Battlestation][battlestation-photo]
![Desktop Screenshot][desktop-screenshot]

# Dependencies

- `fish`
- `bat`
- `fd`
- `sd`
- `fzf`
- `tmux`
- `rsync`
- `exa`
- `nnn`
- `nvim`

# Setup

```
set dfp ~/.config/lytedev-dotfiles
git clone https://git.lyte.dev/lytedev/dotfiles.git $dfp && cd $dfp
./common/bin/dotfiles-setup
# symlink host/os-specific directories
ezln ./os/linux $ENV_PATH/linux
# setup again once env has all the layers you want
dotfiles-setup
```

# Basic Usage

# To Do

- Wifi + Home DNS
- Rotate/switch gpg keys and password-store, setup properly on phone

  - Maybe something age/sops-based?

- Layered gitconfig?
- Get out of Google!
  - `calcurse` for Calendar management?
  - `aerc` or `neomutt` for email?
  - My home-grown backup network for Drive?
  - Photos?
- Hibernation and proper power management for laptop?
- **Learn to use `journalctl`**
- Fix sway workspaces on desktop?
- Neovim LSP
- Move to NixOS (WIP) or Guix? Declarative is the future!
- Better/more secure remote management configuration in dotfiles? [1][1]
- Setup network file share?
- Home VPN
- Add vim in the terminal as the handler for many MIME types (xdg-open and such)
  for the rare time I'm in a file manager or for opening easily from
  the browser.
  - This goes for navigating "into" a file in `nnn`
- Unify all the common variables... somehow? (and use templates and `envsubst`?)
- [Vimux](https://github.com/benmills/vimux)?
- Investigate systemd services that may help with various tasks (homed, etc.)
- Be more macOS friendly, since work may require that

[upstream]: https://git.faceless.lytedev.io/lytedev/dotfiles
[github]: https://github.com/lytedev/dotfiles
[desktop-screenshot]: https://files.lyte.dev/unix/desktop-screenshot.png
[battlestation-photo]: https://files.lyte.dev/unix/battlestation.jpg
[1]: https://smallstep.com/blog/ssh-tricks-and-tips/
