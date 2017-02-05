# My Dotfiles

This repository contains the majority of application or OS configuration files
I use on a daily basis. I keep the here and public in an effort to inform others
who may not know either how to go about organizing such files or to learn how to
achieve certain behavior in their software and to have quick and easy access for
myself when setting up a new machine.

## Priorities

I have specific needs and desires (as does any developer) and I will lay those
out in order of priority here:

* These files are primarily configured for Linux, (specifically, Arch Linux) but
  I try to keep the OS-specific stuff in the `os-specific` directory.
* I am also primarily a Web Developer, so my configuration will reflect that.
* I rely heavily on Google's products and services. I know some are eager to
  avoid that.
* I also prefer apps in my terminal. If I could, I would do everything that
  makes sense to do so in a terminal using only my keyboard. **So if you know
  about really cool and usable terminal-based software, let me know!**
* I prefer keeping my dotfiles as portable as possible (within reason).
* These dotfiles should be very quick to setup and get going.
* I aim to keep the dotfiles flexible and extendible, as I usually use them on
  multiple machines with specific use-cases. For example, a shared laptop should
  allow for other non-technical users ease-of-access, while my workstation
  should focus on being quick, powerful, and highly usable for me alone.

## Applications

There are several types of applications I use every day, some more than others,
and sometimes different applications that have the same purpose. Here are the
applications I use (the primary one is *italicized*, the one I would like to
become my primary or am very interested in using in more depth is in **bold**)
for various tasks:

* **Terminal Emulators**: *rxvt-unicode*
* **Text Editors**: **vim/Neovim**, Sublime Text, Kakoune
* **Terminal Multiplexers**: *tmux*
* **Web Browser**: *Google Chrome*, **qutebrowser**, luakit
* **Music**: *Google Play Music*
* **Email**: *Google Inbox*, Gmail, **mutt**
* **Image Editing**: *GIMP*, *Inkscape*, **Krita**
* **Documents**: *Google Drive*, though Dropbox's Paper looks neat and I've
  heard too many good things about LaTeX.
* **Gaming**: *Steam*, *various emulators*

## Workflow

Here are some bullet points on my workflow as a Web Developer:

* **Text Editing**: I use `vim`/`Neovim` in my terminal as my primary text
  editor. I usually run it in a `tmux` session alongside a few terminals to have
  a very flexible IDE-like development environment. More on that in other bullet
  points.
* **Version Control**: I use `git` in the terminal (sometimes I pop into
  GitKraken if I need to do anything crazy) and commit often. I work in a branch
  named "dev" until it's time to go live, then I merge into master. Other
  branches beyond "dev" are used for trying crazy things or during large
  refactors so I can very quickly jump back if needed.
* **Compiler/Debugging**: I rely heavily on auto-reloading and
  watch-and-test-and-compile features during development to iterate quickly.
  Tools such as `webpack` and `webpack-dev-server` are amazing. If you try to do
  anything to weird or crazy, though, configuring webpack properly can be
  hazardous to the mind. Or I'm just doing things very wrong. Chrome's dev tools
  are also killer in this department.
* **Testing**: I don't do much testing. This is bad and I'm working on it!

## To Do and Improvements

* Add more content to the other sections?
* Start refactoring old dotfiles and scripts.
