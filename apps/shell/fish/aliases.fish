#!/usr/bin/env fish

# ls aliases
alias lx 'ls -lXB' # order by filetype
alias lk 'ls -lSr' # order by filesize reversed
alias lt 'ls -ltr' # order by file modified time
alias lc 'ls -ltcr' # order by filectime
alias lu 'ls -ltur' # order by file access time
alias ls 'ls -h --color --group-directories-first' # flat view w/ directories first
alias l  'ls -h --color --group-directories-first' # same as above
alias ll 'ls -lv --group-directories-first' # non-flat view
alias lm 'll | more'
alias lr 'll -R' # please don't - why is this even here...?
alias la 'll -A' # show all

# other file aliases
alias tree 'tree -Csuh'
alias f fzf
alias cp 'rsync -ah --progress'

# gets the newest file in the current directory (or the specified directory
# if one is provided)
function ltl
	set d $argv[1] .
	set -l l ""
	for f in $d[1]/*
		if test -z $l; set l $f; continue; end
		if command test $f -nt $l; and test ! -d $f
			set l $f
		end
	end
	echo $l
end

function scount -d "Silent count" -w count
	count $argv > /dev/null
end

function ltld
	set d $argv[1] .
	set -l l ""
	for f in $d[1]/*
		if test -z $l; set l $f; continue; end
		if command test $f -nt $l; and test -d $f
			set l $f
		end
	end
	echo $l
end

alias vltl "vim (ltl)"
alias cdltl "cd (ltld)"
alias ltlv vltl

function d -w cd
	if scount $argv
		cd $argv || exit 1
	else
		cd $NICE_HOME || exit 1
	end
	la
end

# navigation aliases
function c -w cd
	if scount $argv
		cd $NICE_HOME && d $argv || exit 1
	else
		d $NICE_HOME
	end
end

alias cd.. "d .."
alias cdd "d $DOTFILES_PATH" # go to dotfiles
alias cde "d $ENV_PATH" # go to env dotfiles
alias cdc "d $XDG_CONFIG_HOME" # go to ~/.config
alias cdn "d $NOTES_PATH"
alias cdl "d $NICE_HOME/dl"
alias cdg "d $NICE_HOME/games"

# quick parent-directory aliases
alias .. "d .."
alias ... "d ../.."
alias .... "d ../../.."
alias ..... "d ../../../.."
alias ...... "d ../../../../.."
alias ....... "d ../../../../../.."
alias ........ "d ../../../../../../.."
alias ......... "d ../../../../../../../.."

# tmux aliases
# TODO: see if this can be worked around?
alias tmnew "tmux new -s"
alias tmls "tmux list-sessions | rg --color never -o '^(.*?):.*?\(.*?\)(.*)\$' -r '\$1\$2'"
alias tmatt "tmux attach -t"
alias tu "tmux attach -t utils || tmux new -s utils"
alias tdf "tmux attach -t dotfiles || tmux new -s dotfiles -c $DOTFILES_PATH"
alias tmon "tmux attach -t monitoring || tmux new -s monitoring"
alias tcom "tmux attach -t comms || tmux new -s comms"
alias tn "tmux attach -t notes || tmux new -s notes -c $NOTES_PATH"
alias tm "tmux attach -t music || tmux new -s music"

# git aliases
# TODO: make these git aliases in the gitconfig?
function g
	if scount $argv
		git $argv
	else
		git status
	end
end
alias gs "git status"
alias gd "git diff"
alias gds "gd --staged"
# alias gdv "git dv" # TODO: what is this?
alias gpl "git pull"
alias ga "git add"
alias gcm "git commit -m"
alias gco "git checkout"
alias gp "git push"
alias gpa "git push --all && git push --tags"
alias gpt "git push && git push --tags"
alias gpf "git push --force-with-lease"
alias gac "git add -A && git commit"
alias gacnv "git add -A && git commit --no-verify"
alias gsur "git submodule update --remote"
alias glf "git ls-files"
alias gl "git log --pretty=format:\"%h %ad%x09%an%x09%s\" --date=short"

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
alias C "clear && clear"
alias r "ranger"
alias rn "/usr/bin/watch -n 1"
alias sctl "sudo systemctl"
alias sctlu "systemctl --user"
alias logs "sudo journalctl"
alias logsr "sudo journalctl -r"
alias logsf "sudo journalctl -f"
alias bt "sudo bluetoothctl"
alias btctl "bt"
alias btctl "sudo bluetoothctl"
alias pbcopy "clip"
alias pt "htop -t" # experimental htop tree-view-by-default
alias resrc "source $XDG_CONFIG_HOME/fish/config.fish"
alias redshift "redshift -r -l 39.0997:-94.5786 -t 6500K:2500K"
alias noredshift "killall redshift; redshift -P -O 5700"
alias gpmdpe "electron --app=/usr/share/gpmdp/resources/app.asar"
alias t "task"
alias sc "sc-im"
alias scs "sc-im $NOTES_PATH/_scratch.sc"
alias disks "lsblk && df -h"
alias dd "dd status=progress"
alias wifi "sudo nmtui"
alias year 'cal (date +%Y)'
alias y year
alias pa pulsemixer
alias vd vdiff

# games aliases
# this sometimes fixes steam dynamic library issues?
alias lsteam "env LD_PRELOAD='/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1 /usr/$LIB/libgpg-error.so' steam"

# neomutt is better
alias mutt "neomutt"
alias mail "mutt"

# fsw aliases
alias fsw-mix-test 'fsw "mix test" ./**/*.{ex,exs,erl,hrl,xrl,yrl}'

# weechat aliases
function chat
	set -l pass (pass config/weechat-passphrase | head -n 1)
	env WEECHAT_PASSPHRASE=$pass weechat
end

function rgl
	# ripgrep | less
	rg --color always $argv | less -r
end

# grep aliases
alias rg "rg --text"
alias grep "rg"
