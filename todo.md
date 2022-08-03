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

## Helix

Here are some things Helix doesn't do well that are common use cases for my
Neovim setup:

- Session management: https://github.com/helix-editor/helix/issues/401
- "Infinite" undo persistence
  - I want to be able to open a file, make changes, save it, close helix, re-
    open that same file and still be able to undo all the changes I made - one
    might argue that I should just use git better, and you would be right, but this
    is something I've come to rely on for the time being
- Usable as PAGER, VISUAL, MANPAGER, GIT_PAGER, etc: https://github.com/helix-editor/helix/issues/1074
- The ability to `:reflow` with indentation taken into account?
