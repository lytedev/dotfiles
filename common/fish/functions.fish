function has_command --wraps=command --description "Exits non-zero if the given command cannot be found"
	command --quiet --search $argv[1]
end

if has_command exa
	alias ls 'exa --group-directories-first'
	alias l ls
	alias tree 'ls --tree --level=3'
	alias lt 'll --sort=modified'
	alias lat 'la --sort=modified'
	alias lc 'lt --sort=accessed'
	alias lT 'lt --reverse'
	alias lC 'lc --reverse'
end

alias lA 'ls --all'
alias ll 'ls -l'
alias la 'll --all'

function scount --wraps=count --description "Silent count exits with a non-zero status if no arguments given to count"
	count $argv > /dev/null
end

function d --wraps=cd --description "Quickly jump to NICE_HOME (or given relative or absolute path) and list files."
	if scount $argv
		cd $argv
	else
		cd $NICE_HOME
	end
	la
end

function c --wraps=cd --description "Quickly jump to a subdirectory of NICE_HOME (or just to NICE_HOME if none given)"
	if scount $argv
		cd $NICE_HOME && d $argv
	else
		d $NICE_HOME
	end
end

alias cd.. "d .."
alias cdd "d $DOTFILES_PATH"
alias cde "d $XDG_CONFIG_HOME/lytedev-env"
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

if has_command nnn
	function r --wraps nnn --description 'Run nnn with support for jump-to-directory-on-exit via ^G'
		# TODO: this would break with multiple nnn instances, right?
		# probably need to mktemp instead
		set -u NNN_TMPFILE (mktemp)
		export NNN_TMPFILE
		nnn -P p $argv
		test -e $NNN_TMPFILE && source $NNN_TMPFILE && cp $NNN_TMPFILE ~/.nnn-last-tmpfile && rm $NNN_TMPFILE
	end
	alias l r
end

has_command tmux && alias t "tmux"
has_command rsync && alias rcp 'rsync -r -ah --progress'
has_command bat && alias cat bat

if has_command git
	function g -w git
		if scount $argv; git $argv
		else; git status; end
	end
end

if has_command docker
	alias dlf "docker logs --tail=500 -f"
	alias ctop "docker run --rm -ti -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest"
end

if has_command docker-compose
	alias dclf "docker-compose logs --tail=500 -f"
end

if has_command weechat
	function chat
		set -l pass (pass config/weechat-passphrase | head -n 1)
		env WEECHAT_PASSPHRASE=$pass weechat
	end
end

if has_command rg
	function rgl; rg --color always $argv | less -r; end
	alias rg "rg --text"
	alias grep "rg"
	alias gr "rg"
end

if has_command kubectl
	alias k "kubectl"
	alias kg "k get"
end

alias vim $EDITOR
alias vi $EDITOR
alias v $EDITOR
alias e $EDITOR
alias sv "sudo -E $EDITOR"
alias se sv
alias svim sv

function ltl --wraps=ls --description "Echoes the name of the file most recently modified either in the current directory or in the given path"
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

function ltld --wraps=ls --description "Echoes the name of the directory most recently modified either in the current directory or in the given path"
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

alias vltl "$EDITOR (ltl)"
alias cdltl "cd (ltld)"

function p
	set ip 8.8.8.8
	set -q argv[1] && set ip $argv[1]
	ping $ip $argv[2..]
end
function pp --description "Keeps trying to ping 8.8.8.8 forever"
	while not ping -n 1 -w 5 8.8.8.8
		sleep 1
	end
end

alias C "clear; set -q TMUX && begin; has_command tmux && tmux clear-history; end || true"

if has_command systemctl
	alias sctl "sudo systemctl"
	alias sctlu "systemctl --user"
	alias bt "sctl start bluetooth && sudo bluetoothctl"
	alias btctl "bt"
end

alias resrc "source $XDG_CONFIG_HOME/fish/config.fish; fish_user_key_bindings"
has_command sc && alias scs "sc $NOTES_PATH/_scratch.sc"

alias dd "dd status=progress"
alias year 'cal (date +%Y)'
alias mount 'sudo -E mount'
alias umount 'sudo -E umount'

has_command xdg-open && alias open xdg-open
has_command docker && alias dc "docker compose"

function fish_preexec
	test -n $TMUX && begin
		set envlist (tmux show-environment)
		for var in DISPLAY WAYLAND_DISPLAY
			set -gx $var (echo $envlist | rg '^'$var'=(.*)$' -r '$1')
		end
	end
end

# source:
# https://github.com/ivakyb/fish_ssh_agent/blob/master/functions/fish_ssh_agent.fish
function __ssh_agent_is_started -d "check if ssh agent is already started"
   if begin; test -f $SSH_ENV; and test -z "$SSH_AGENT_PID"; end
      source $SSH_ENV > /dev/null
   end

   if test -z "$SSH_AGENT_PID"
      return 1
   end

   ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep -q ssh-agent
   #pgrep ssh-agent
   return $status
end

function __ssh_agent_start -d "start a new ssh agent"
   ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
   chmod 600 $SSH_ENV
   source $SSH_ENV > /dev/null
   true  # suppress errors from setenv, i.e. set -gx
end

function fish_ssh_agent --description "Start ssh-agent if not started yet, or uses already started ssh-agent."
   if test -z "$SSH_ENV"
      set -xg SSH_ENV $HOME/.ssh/environment
   end

   if not __ssh_agent_is_started
      __ssh_agent_start
   end
end
