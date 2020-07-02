# dotfiles by lytedev

[🖥️ Upstream][upstream] • [🐙 GitHub Mirror][github]

![Desktop Screenshot][desktop-screenshot]

This repository contains the majority of application or OS configuration files
I use on a daily basis. I keep them public in an effort to inform others who may
not know either how to go about organizing such files or to learn how to achieve
certain behavior in their software and to have quick and easy access for myself
when setting up a new machine.

## Setup

**NOTE**: Unless you're me, you probably shouldn't use my setup exactly. Just
take chunks you like instead! Backup your files first!

```
git clone https://git.lyte.dev/lytedev/dotfiles.git ~/.config/dotfiles
cd ~/.config/dotfiles && ./setup.bash # follow the instructions!
```

## Priorities

+ Productivity
+ Flexibility and extensibility
+ Primarily configured for Linux
+ Terminal-based applications that play well with others
+ Quick setup
+ Portability

## Primary Applications

+ **Terminal**: Kitty + tmux
+ **Editor**: Neovim
+ **Browser**: Firefox
+ **Music**: Google Play Music in Firefox
+ **Email**: Gmail in Firefox
+ **Image Editing**: Inkscape, Krita, GIMP
+ **Gaming**: Steam, Dolphin Emulator, Lutris

## Workflow

*Coming someday... maybe!*

## Improvements

+ Makefile instead of setup script
+ Vulkan is broken on my desktop
+ `c` (and similar aliases) could utilize `CDPATH` envvar?
+ Better/more secure remote management configuration in dotfiles? [1][1]
+ Add vim in the terminal as the handler for many MIME types (xdg-open and such)
		for the rare time I'm in a file manager or for opening easily from
		the browser.
+ Unify all the common variables... somehow? (and use templates and `envsubst`?)
+ [Vimux](https://github.com/benmills/vimux)?
+ Custom Iosevka font with kitty-compatible ligatures?
+ Setup network file share?
+ Investigate systemd services that may help with various tasks (homed, etc.)


[upstream]: https://git.faceless.lytedev.io/lytedev/dotfiles
[github]: https://github.com/lytedev/dotfiles
[desktop-screenshot]: https://lyte.dev/unix/desktop-screenshot.png
[1]: https://smallstep.com/blog/ssh-tricks-and-tips/
