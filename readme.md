# My Dotfiles

[🖥️ Upstream][upstream] • [🐙 GitHub Mirror][github]

![Desktop Screenshot][desktop-screenshot]

This repository contains the majority of application or OS configuration files
I use on a daily basis. I keep the here and public in an effort to inform others
who may not know either how to go about organizing such files or to learn how to
achieve certain behavior in their software and to have quick and easy access for
myself when setting up a new machine.

## Setup

* Clone the repo into `~/.config/dotfiles`
* Run `~/.config/dotfiles/setup.bash`
* Read the warning, obey it, backup your files, *then* agree
* **Optional**: Reboot once the script finishes

## Priorities

I have specific needs and desires (as does any developer) and I will lay those
out in order of priority here:

* These files are primarily configured for Linux, (specifically, Arch Linux) but
  I try to keep the OS-specific stuff in the `os-specific` directory.
* I also prefer apps in my terminal. If I could, I would do everything that
  makes sense to do so in a terminal using only my keyboard. **So if you know
  about really cool and usable terminal-based software, let me know!**
* I prefer keeping my dotfiles as portable as possible (within reason) though
		this is obviously very difficult since I only run one OS.
* Setup should be very quick (downloading and installing packages aside).
* I aim to keep the dotfiles flexible and extendible, as I usually use them on
  multiple machines with specific use-cases. For example, a shared laptop should
  allow for other non-technical users ease-of-access, while my workstation
  should focus on being quick, powerful, and highly usable for me alone.

## Applications

There are several types of applications I use every day, some more than others,
and sometimes different applications that have the same purpose. Here are the
applications I use:

* **Terminal Emulator**: Kitty
* **Text Editor**: Neovim
* **Terminal Multiplexers**: tmux
* **Web Browser**: Firefox
* **Music**: Google Play Music
* **Email**: Google Inbox, mutt
* **Image Editing**: GIMP, Inkscape, Krita, Aseprite
* **Documents**: Neovim + Markdown, sc-im, LibreOffice
* **Gaming**: Steam, various emulators

## Workflow

Here are some bullet points on my workflow:

* **Text Editing**: I use `Neovim` in my terminal as my primary text
		editor. I usually run it in a `tmux` session alongside a few terminals to
		have a very flexible IDE-like development environment. More on that in other
		bullet points. I keep a `tmux` session for each project or group of
		terminals concerning a similar mind-space.
* **Version Control**: I use `git` in the terminal and commit often. I work in
		feature branches that go to a `dev` branch as sort of a staging area for
		testing until it's time to go live, then I merge into master.
* **Compiler/Debugging**: I rely heavily on auto-reloading and
		watch-and-test-and-compile features during development to iterate quickly.
		Language servers, linters, and simple file watches to trigger your tests are
		amazing tools to take care of the cruft of writing code and integrating them
		heavily into Neovim is my current top need/priority.

## To Do and Improvements

* Add vim in the terminal as the handler for many MIME types (xdg-open and such)
		for the rare time I'm in a file manager or for opening easily from
		the browser.
* Unify all the common variables... somehow? (and use templates and `envsubst`?)
* Makefile instead of setup script
* [Vimux](https://github.com/benmills/vimux)?
* Nerd Fonts with ligatures and icons for Kitty
* Setup network file sharing directory


[upstream]: https://git.faceless.lytedev.io/lytedev/dotfiles
[github]: https://github.com/lytedev/dotfiles
[desktop-screenshot]: https://lyte.dev/unix/desktop-screenshot.png
