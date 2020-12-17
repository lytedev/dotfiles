#!/usr/bin/env fish

alias ls 'exa --group-directories-first'
alias tree 'ls --tree --level=3'
alias lA 'ls -a'
alias ll 'ls -l'
alias la 'll -a'
alias lt 'll -t modified'
alias lT 'lt -r'
alias lc 'lt -t accessed'
alias lC 'lc -r'

function d -w cd --description "Quickly jump to NICE_HOME (or given relative or absolute path) and list files."
	if scount $argv
		cd $argv || exit 1
	else
		cd $NICE_HOME || exit 1
	end
	la
end

function c --description "Quickly jump to a subdirectory of NICE_HOME (or just to NICE_HOME if none given)"
	if scount $argv
		cd $NICE_HOME && d $argv || exit 1
	else
		d $NICE_HOME
	end
end
complete --erase --command c
complete --command c -a \
	"(pushd $NICE_HOME && fd . . --max-depth 1 --min-depth 1 -x ls -p && popd)"

alias cd.. "d .."
alias cdd "d $DOTFILES_PATH"
alias cde "d $ENV_PATH"
alias cdc "d $XDG_CONFIG_HOME"
alias cdn "d $NOTES_PATH"
alias cdl "d $XDG_DOWNLOAD_DIR"
alias cdg "d $XDG_GAMES_DIR"
alias .. "d .."
alias ... "d ../.."
alias .... "d ../../.."
alias ..... "d ../../../.."
alias ...... "d ../../../../.."
alias ....... "d ../../../../../.."
alias ........ "d ../../../../../../.."
alias ......... "d ../../../../../../../.."

function r --wraps nnn --description 'Run nnn with support for jump-to-directory-on-exit via ^G'
	# TODO: this would break with multiple nnn instances, right?
	# probably need to mktemp instead
	set NNN_TMPFILE "$XDG_CONFIG_HOME/nnn/.lastd"
	nnn -P p $argv
	test -e $NNN_TMPFILE && source $NNN_TMPFILE && rm $NNN_TMPFILE
end
alias l r

alias t "tmux"
alias rcp 'rsync -r -ah --progress'
alias cat bat

function g -w git
	if scount $argv; git $argv
	else; git status; end
end

alias dlf "docker logs --tail=500 -f"
alias dclf "docker-compose logs --tail=500 -f"
alias ctop "docker run --rm -ti -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest"

function chat
	set -l pass (pass config/weechat-passphrase | head -n 1)
	env WEECHAT_PASSPHRASE=$pass weechat
end

function rgl; rg --color always $argv | less -r; end

alias k "kubectl"
alias kg "k get"

alias rg "rg --text"
alias grep "rg"
alias gr "rg"

alias vim "$EDITOR"
alias vi "$EDITOR"
alias v "$EDITOR"
alias e "$EDITOR"
alias se "sudo -E $EDITOR"
alias svim "se"

alias vltl "$EDITOR (ltl)"
alias cdltl "cd (ltld)"

function pp; while not ping -n 1 -t 5 8.8.8.8; sleep 1; end; end
alias p "ping 8.8.8.8"
alias C "clear; set -q TMUX && tmux clear-history"
alias sctl "sudo systemctl"
alias sctlu "systemctl --user"
alias bt "sctl start bluetooth && sudo bluetoothctl"
alias btctl "bt"
alias resrc "source $XDG_CONFIG_HOME/fish/config.fish"
alias sc "sc-im"
alias scs "sc-im $NOTES_PATH/_scratch.sc"
alias disks "lsblk && df -h"
alias dd "dd status=progress"
alias wifi "sudo iwctl"
alias year 'cal (date +%Y)'
alias mount 'sudo -E mount'
alias pa pulsemixer
