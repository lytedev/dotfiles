# lytedev's dotfiles

My various configuration files. I can't recommend using them directly, just
take what you like.

## Links

[🖥️ Upstream][upstream] • [🐙 GitHub Mirror][github]

# Basic Setup

    curl -LO lyte.dev/df.sh && . df.sh

## Manual Setup

    git clone https://git.lyte.dev/lytedev/dotfiles.git "$HOME/.config/lytedev-dotfiles"
    "$HOME/.config/lytedev-dotfiles/common/bin/dotfiles-setup"

# Repo Structure

My dotfiles are composed together by layering "environments" since I want my dotfiles to be flexible across servers, laptops, desktops, and even my phone (via Termux).

    lytedev-dotfiles
    |- common --- common to all hosts and operating systems
    | |- bin ------- programs or scripts useful to all hosts/OSs
    | |- data ------ shared storage for certain scripts
    | `- {app...} -- configuration related to {app}
    |- host ----- specific to specific hosts or types of hosts
    | |- desktop --- for desktop-class machines
    | |- headless -- for server-class machines with no display/GUI
    | `- laptop ---- for portable, battery-having machines
    `- os ------- specific to operating systems
      |- linux ----- you alread know <3
      |  |- desktop ------ for desktop-class machines
      |  |- headless ----- for server-class machines with no display/GUI
      |  |- bin ---------- programs/scripts useful to linux machines
      |  |- {distro...} -- configuration related to {distro}
      |  `- {app...} ----- linux-specific configuration related to {app}
      `- macos ----- for those stupid macbooks work tries to make you use

Any environment should be able to extend the configuration of any application
in some unique way. This isn't possible with all applications, of course, since
some programs do not make it easy (or possible) to include multiple
configuration files or to extend a single file by having it include others via
globs or some other mechanism.

One example of doing this well is with fish:

    for s in $ENV_PATH/*/config.d.fish; source $s (dirname $s); end

This way, if any environment (a dir in $ENV_PATH) has a `config.f.fish` script
inside, it will be sourced by the main configuration file.

Likewise, some setup only happens in certain environments via the
`dotfiles-setup.d.fish` script.

One important note on environments is that even though they are laid out like
a tree (directories), you do NOT automatically get the parent-environment's
configuration, so if you are setting up a Arch Linux desktop machine, you
cannot only link the `os/linux/arch` and `host/desktop` environments but will
also need to include `os/linux` if you want the Linux-generic configuration.

# Post-Setup

You will want to symlink relevant environment layers into the `$ENV_PATH` in
order to have your OS-specific applications be configured and common
applications configured for the host OS.

There's a handy `fzf`-based script that makes this super easy (note that you
can select multiple environments with TAB):

    dotfiles-link-environments

You can also list the possible environments:

    cat $DOTFILES_PATH/common/envs

And then link them yourself (note that environments must be in $ENV_PATH and
cannot be nested, so replacing slashes with dashes is a nice way to show what's
going on):

    ln -s (pwd)/os/linux $ENV_PATH/os-linux
    ln -s (pwd)/os/linux/arch $ENV_PATH/os-linux-arch
    ln -s (pwd)/host/laptop $ENV_PATH/host-laptop
    ln -s (pwd)/host/laptop/third $ENV_PATH/os-laptop-third
    # etc...

And run setup again once you've finished linking all related environments:

    dotfiles-setup

# Screenshots

## Arch Linux Desktop

![Battlestation][battlestation-photo]
![Desktop Screenshot][desktop-screenshot]

[upstream]: https://git.faceless.lytedev.io/lytedev/dotfiles
[github]: https://github.com/lytedev/dotfiles
[desktop-screenshot]: https://files.lyte.dev/unix/desktop-screenshot.png
[battlestation-photo]: https://files.lyte.dev/unix/battlestation.jpg
