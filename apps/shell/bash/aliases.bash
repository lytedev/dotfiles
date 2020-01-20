#!/usr/bin/env bash

# filesystem aliases
alias lx='ls -lXB' # order by filetype
alias lk='ls -lSr' # order by filesize reversed
alias lt='ls -ltr' # order by file modified time
alias lc='ls -ltcr' # order by filectime
alias lu='ls -ltur' # order by file access time
alias ls='ls -h --color --group-directories-first' # flat view w/ directories first
alias l='ls -h --color --group-directories-first' # same as above
alias ll='ls -lv --group-directories-first' # non-flat view
alias lm='ll | more'
alias lr='ll -R' # please don't - why is this even here...?
alias la='ll -A' # show all
alias tree='tree -Csuh'
alias f='fzf'
alias cp="rsync -ah --progress"
alias year="cal $(date +%Y)"
alias y="year"

# gets the newest function for the current directory (or the specified directory
# if one is provided)
function ltl() {
	local d="${1-$PWD}"
	unset -v l
	for f in "$d"/*; do
		[[ $f -nt $l ]] && [[ ! -d $f ]] && l="$f"
	done
	echo "$l"
}

function ltld() {
	local d="${1-$PWD}"
	unset -v l
	for f in "$d"/*; do
		[[ $f -nt $l ]] && [[ -d $f ]] && l="$f"
	done
	echo "$l"
}

alias vltl="vim \"\$(ltl)\""
alias cdltl="cd \"\$(ltld)\""
alias ltlv="vltl"

# navigation aliases
function c() {
	if [[ -n $1 ]]; then
		cd "${NICE_HOME}" || exit 1
	else
		cd "${NICE_HOME}" && cd "${1}" || exit 1
	fi
}
alias cd..="cd .."
alias cdd="cd \"\$DOTFILES_PATH\"" # go to dotfiles
alias cde="cd \"\$ENV_PATH\"" # go to current dotfiles...? env
alias cdc="cd \"\$XDG_CONFIG_HOME\"" # go to ~/.config
alias cdn="cd \"\$NOTES_PATH\""
alias cdl="cd \"\$NICE_HOME/dl\""
alias cdg="cd \"\$NICE_HOME/games\""

# quick parent-directory aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."
alias .........="cd ../../../../../../../.."

# tmux aliases
# TODO: see if this can be worked around?
alias tmnew="tmux new -s"
alias tmls="tmux list-sessions"
alias tmatt="tmux attach -t"
alias tu="tmux attach -t utils || tmux new -s utils"
alias tdf="tmux attach -t dotfiles || tmux new -s dotfiles -c \"\$DOTFILES_PATH\""
alias tmon="tmux attach -t monitoring || tmux new -s monitoring"
alias tcom="tmux attach -t comms || tmux new -s comms"
alias tn="tmux attach -t notes || tmux new -s notes -c \"\$NOTES_PATH\""
alias tm="tmux attach -t music || tmux new -s music"

# git aliases
# TODO: make these git aliases in the gitconfig?
g() {
	if [[ $# == '0' ]]; then
		git status
	else
		git $*
	fi
}
alias gs="git status"
alias gd="git diff"
alias gds="git diff --staged"
# alias gdv="git dv" # TODO: what is this?
alias gpl="git pull"
alias gp="git push"
alias gpa="git push --all && git push --tags"
alias gpt="git push && git push --tags"
alias gpf="git push --force-with-lease"
alias gac="git add -A && git commit"
alias gacnv="git add -A && git commit --no-verify"
alias gsur="git submodule update --remote"
alias glf="git ls-files"
alias gl="git log --pretty=format:\"%h %ad%x09%an%x09%s\" --date=short"

# docker aliases
alias dlf="docker logs --tail=500 -f"
alias dclf="docker-compose logs --tail=500 -f"
alias ctop="docker run --rm -ti -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest"

# misc aliases
alias p="ping 8.8.8.8"
alias C="clear && clear"
alias r="ranger"
alias rn="/usr/bin/watch -n 1"
alias sctl="sudo systemctl"
alias sctlu="systemctl --user"
alias logs="sudo journalctl"
alias logsr="sudo journalctl -r"
alias logsf="sudo journalctl -f"
alias bt="sudo bluetoothctl"
alias btctl="bt"
alias btctl="sudo bluetoothctl"
alias pbcopy="clip"
alias pt="htop -t" # experimental htop tree-view-by-default
alias resrc="source \$HOME/.bashrc"
alias redshift="redshift -r -l 39.0997:-94.5786 -t 6500K:2500K"
alias gpmdpe="electron --app=/usr/share/gpmdp/resources/app.asar"
alias t="task"
alias sc="sc-im"
alias scs="sc-im \"\$NOTES_PATH/_scratch.sc\""
alias disks="lsblk && df -h"
alias dd="dd status=progress"
alias wifi="sudo nmtui"
alias pa="pulsemixer"

# games aliases
# this sometimes fixes steam dynamic library issues?
alias lsteam="LD_PRELOAD='/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1 /usr/$LIB/libgpg-error.so' steam"

# override the man commands with vim
alias _man="\\man"
alias man="vman"

# neomutt is better
alias mutt="neomutt"

# fsw aliases
alias fsw-mix-test="fsw \"mix test\" ./**/*.{ex,exs,erl,hrl,xrl,yrl}"

# weechat aliases
alias chat="WEECHAT_PASSPHRASE=\"\$(pass config/weechat-passphrase | head -n 1)\" weechat"