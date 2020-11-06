# dotfiles by lytedev

This repository is undergoing some massive changes.

Tread lightly.

```
curl -s -L https://git.lyte.dev/lytedev/dotfiles/raw/branch/nixos/init.sh
```

[🖥️ Upstream][upstream] • [🐙 GitHub Mirror][github]


## Improvements

+ Move to NixOS or Guix? Declarative is the future!
+ Custom Iosevka font with kitty-compatible ligatures?
+ Makefile instead of setup script
+ `c` (and similar aliases) could utilize `CDPATH` envvar?
+ Better/more secure remote management configuration in dotfiles? [1][1]
+ Setup network file share?
+ Add vim in the terminal as the handler for many MIME types (xdg-open and such)
	for the rare time I'm in a file manager or for opening easily from
	the browser.
+ Unify all the common variables... somehow? (and use templates and `envsubst`?)
+ [Vimux](https://github.com/benmills/vimux)?
+ Investigate systemd services that may help with various tasks (homed, etc.)


[upstream]: https://git.faceless.lytedev.io/lytedev/dotfiles
[github]: https://github.com/lytedev/dotfiles
[desktop-screenshot]: https://files.lyte.dev/unix/desktop-screenshot.png
[1]: https://smallstep.com/blog/ssh-tricks-and-tips/
