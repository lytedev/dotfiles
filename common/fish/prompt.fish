set MAX_PATH_PIECE_CHARS 3

function get_hostname
	has_command hostname && hostname || cat /etc/hostname
end

function fish_greeting
	set_color -b black brblack
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
	if test (id -u) -eq 0
		if test $last_cmd_status -eq 0
			set_color -b blue black
		else
			set_color -b red black
		end
		printf " SUDO $USER@$hostname "
	else
		if test $last_cmd_status -eq 0
			set_color blue
		else
			set_color red
		end
		printf %s@%s $USER (echo $hostname | cut -d '.' -f1)
	end
	set_color normal
	printf " "
	set_color magenta
	printf (preprocess_pwd)""
	set_color normal
	printf " "
end

function fish_mode_prompt; end

# function fish_right_prompt
# 	set_color brblack
# 	switch $fish_bind_mode
# 		case default
# 			echo 'N'
# 		case insert
# 			echo 'I'
# 		case replace_one
# 			echo 'R'
# 		case replace
# 			echo 'R'
# 		case visual
# 			echo 'V'
# 	end
# end
