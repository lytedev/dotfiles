set MAX_PATH_PIECE_CHARS 3

function get_hostname
	has_command hostname && hostname || cat /etc/hostname
end

function fish_greeting
	set_color -b normal brblack
	printf "%s@%s %s\n" $USER (get_hostname) (date)
end

function preprocess_pwd
	test (pwd) = / && echo "/" && return 1
	test (pwd) = $NICE_HOME && echo "~" && return 0
	pwd | cut -c2- | \
		awk '{n=split($0,p,"/");for(i=1;i<=n;i++){if(i==n){printf "/%s",p[i]}else{printf "/%.'$MAX_PATH_PIECE_CHARS[1]'s",p[i]}}}'
end

function fish_prompt
	set last_cmd_status $status
	if set -q SUDO_USER
		set_color -b yellow black
		printf " SUDO "
		set_color -b normal normal
		printf " "
	end
	if test $last_cmd_status -eq 0
		set_color -b normal blue
	else
		set_color -b normal red
	end
	printf "$USER@$hostname"
	set_color -b normal magenta
	printf " %s" (preprocess_pwd)
	set_color -b normal green
	set -q CMD_DURATION && printf " %dms" $CMD_DURATION
	if jobs -q
		set_color -b normal cyan
		printf " &%d" (jobs -p | wc -l)
	end
	printf "\n"
	set_color brblack
	if test (id -u) -eq 0
		printf "# "
	else
		printf '$ '
	end
	set_color -b normal normal
end

function fish_mode_prompt; end

function fish_right_prompt
end
