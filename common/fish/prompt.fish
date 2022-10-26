set MAX_PATH_PIECE_CHARS 3

function get_hostname
	has_command hostname && hostname || cat /etc/hostname
end

function fish_greeting
	_prompt_prefix
	printf "%s\n" (date)
end

function preprocess_pwd
	test (pwd) = / && echo "/" && return 1
	test (pwd) = $NICE_HOME && echo "~" && return 0
	pwd | cut -c2- | \
		awk '{n=split($0,p,"/");for(i=1;i<=n;i++){if(i==n){printf "/%s",p[i]}else{printf "/%.'$MAX_PATH_PIECE_CHARS[1]'s",p[i]}}}'
end

function _maybe_sudo_prefix
	if set -q SUDO_USER
		set_color -b yellow black
		printf " SUDO "
		set_color -b normal normal
		printf " "
	end
end

function _user_and_host
	if test $argv[1] -eq 0
		set_color -b normal blue
	else
		set_color -b normal red
	end
	printf "$USER@$hostname"
end

function _cur_work_dir
	set_color -b normal magenta
	printf " %s" (preprocess_pwd)
end

function _last_cmd_duration
	set_color -b normal green
	set -q CMD_DURATION && printf " %dms" $CMD_DURATION
end

function _maybe_jobs_summary
	if jobs -q
		set_color -b normal cyan
		printf " &%d" (jobs -p | wc -l)
	end
end

function _user_prompt
	printf "\n"
	set_color brblack
	if test (id -u) -eq 0
		printf '# '
	else
		printf '$ '
	end
	set_color -b normal normal
end

function _maybe_git_summary
	set_color -b normal yellow
	set cur_sha (git rev-parse --short HEAD 2>/dev/null)
	if test $status = 0
		set num_changes (git status --porcelain | wc -l | string trim)
		if test $num_changes = 0
			set num_changes "✔"
		else
			set num_changes "+$num_changes"
		end
		printf " %s %s %s" (git branch --show-current) $cur_sha $num_changes
	end
end

function _prompt_prefix
	set_color -b normal brblack
	printf "# "
end

function fish_prompt
	set last_cmd_status $status
	_prompt_prefix
	_maybe_sudo_prefix
	_user_and_host $last_cmd_status
	_cur_work_dir
	_maybe_git_summary
	_last_cmd_duration
	_maybe_jobs_summary
	_user_prompt
end

function fish_mode_prompt; end

function fish_right_prompt
end
