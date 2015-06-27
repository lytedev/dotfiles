# lytedev's dotfiles

## Configuration

Per-platform configuration scripts for various platforms exist in the `scripts/platform_setup` directory. 
These are mostly used to install various applications or libraries that I use and should definitely
be read through before running as they may very well break your system. They are generally intended
to be run on fresh installs of their respective platforms. 

`scripts/user.sh` should be used to prepare a new user to be bootstrapped. Generally, this just means 
creating good directory structure in the home directory.

TODO: Add per-platform details (Windows, OSX, Arch, NixOS?)

## Installation

Various pre-setup scripts exist for different platforms in the `scripts`
directory. I'll outline their intended use here.

Once you're all set, go ahead and run the `bootstrap.sh` script. This will symlink all the necessary files.

That should be it!

## TODO:

This list is a pseudo-comprehensive list of stuff I want to achieve or have do-able through these dotfiles
as well as a basic TODO list for exploring the world of unix in my dream utopia of command-line heaven.

* email client (mutt?)
* use or create a highly-usable CLI client for KeePass database management

