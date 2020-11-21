#!/usr/bin/env fish

# TODO: exa?
alias lk 'ls -lSr' # order by filesize reversed
alias lt 'ls -ltr' # order by file modified time
alias lc 'ls -ltcr' # order by filectime
alias lu 'ls -ltur' # order by file access time
alias ls 'ls -h --color --group-directories-first' # flat view w/ directories first
alias l  'ls -h --color --group-directories-first' # same as above
alias ll 'ls -lv --group-directories-first' # non-flat view
alias la 'll -A' # show all

# TODO: cat > bat
alias tree 'tree -Csuh'
alias f fzf
alias t "tmux"
alias rcp 'rsync -r -ah --progress'

alias vltl "$EDITOR (ltl)"
alias cdltl "cd (ltld)"

function d -w cd --description "Quickly jump to NICE_HOME (or given dir) and show files."
	if scount $argv
		cd $argv || exit 1
	else
		cd $NICE_HOME || exit 1
	end
	la
end

# navigation aliases
function c --description "Quickly jump to a subdirectory of NICE_HOME (or just to NICE_HOME if none given)"
	if scount $argv
		cd $NICE_HOME && d $argv || exit 1
	else
		d $NICE_HOME
	end
end
complete --erase --command c
complete --command c -a "(pushd $NICE_HOME && fd . . --max-depth 1 --min-depth 1 && popd)"

alias cd.. "d .."
alias cdd "d $DOTFILES_PATH" # go to dotfiles
alias cde "d $ENV_PATH" # go to env dotfiles
alias cdc "d $XDG_CONFIG_HOME" # go to ~/.config
alias cdn "d $NOTES_PATH"
alias cdl "d $XDG_DOWNLOAD_DIR"
alias cdg "d $XDG_GAMES_DIR"
alias cdnx "d $DOTFILES_PATH/env/nix"

# quick parent-directory aliases
alias .. "d .."
alias ... "d ../.."
alias .... "d ../../.."
alias ..... "d ../../../.."
alias ...... "d ../../../../.."
alias ....... "d ../../../../../.."
alias ........ "d ../../../../../../.."
alias ......... "d ../../../../../../../.."

function g -w git
	if scount $argv
		git $argv
	else
		git status
	end
end

# docker aliases
alias dlf "docker logs --tail=500 -f"
alias dclf "docker-compose logs --tail=500 -f"
alias ctop "docker run --rm -ti -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest"

# misc aliases
function pp
	while not ping -n 1 -t 5 8.8.8.8
		sleep 1
	end
end
alias p "ping 8.8.8.8"
alias C "clear && clear" # TODO: this should clear a tmux pane's scrollback/logs
alias r "nnn"
alias sctl "sudo systemctl"
alias sctlu "systemctl --user"
alias bt "sudo bluetoothctl" # TODO: a vi-like tui for bluetooth would be great
alias btctl "bt"
alias resrc "source $XDG_CONFIG_HOME/fish/config.fish"
alias sc "sc-im"
alias scs "sc-im $NOTES_PATH/_scratch.sc"
alias disks "lsblk && df -h"
alias dd "dd status=progress"
alias wifi "sudo nmtui"
alias svim "sudo -E nvim"
alias year 'cal (date +%Y)'
alias mount 'sudo -E mount'
alias pa pulsemixer

# weechat aliases
function chat
	set -l pass (pass config/weechat-passphrase | head -n 1)
	env WEECHAT_PASSPHRASE=$pass weechat
end

function rgl
	# ripgrep | less
	rg --color always $argv | less -r
end

# kubernetes aliases
alias k "kubectl"
alias kg "k get"

# grep aliases
alias rg "rg --text"
alias grep "rg"

alias vim nvim
alias vi nvim

