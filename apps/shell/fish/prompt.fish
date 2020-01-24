#!/usr/bin/env fish

# TODO: if root, background instead?

set MAX_PATH_PIECE_CHARS $BASH_PROMPT_MAX_PATH_PIECE_CHARS 3

# prompt rendering functions
function preprocess_pwd
	test (pwd) = / && echo "/" && return 1
	test (pwd) = $NICE_HOME && echo "~" && return 0
	# with ellipsis
	#echo "$(<<< "$p" cut -c2- | awk '{split($0,p,"/");for(k in p){if(k==length(p)){printf "/%s",p[k]}else{if(length(p[k])>'"$((MAX_PATH_PIECE_CHARS+1))"'){printf "/%.'"$((MAX_PATH_PIECE_CHARS))"'s…",p[k]}else{printf "/%s",p[k]}}}}')"
	# without ellipsis
	echo (pwd) | cut -c2- | awk '{split($0,p,"/");for(k in p){if(k==length(p)){printf "/%s",p[k]}else{printf "/%.'$MAX_PATH_PIECE_CHARS[1]'s",p[k]}}}'
end

function fish_prompt
	if test $status -eq 0
		set_color blue
	else
		set_color red
	end
	printf $USER"@"$hostname" "
	set_color magenta
	printf (preprocess_pwd)" "
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
