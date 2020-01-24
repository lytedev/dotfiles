#!/usr/bin/env fish

# TODO: once, I could set backgrounds

# unused since we handle it ourselves in fish_prompt
set -U fish_color_cwd magenta
set -U fish_color_cwd_root red
set -U fish_color_host normal
set -U fish_color_user blue

set -U fish_color_normal normal # default color
set -U fish_color_command white # base command being run (>ls< -la)
set -U fish_color_param white # command's parameters
set -U fish_color_end green # command delimiter/separators (; and &)
set -U fish_color_error red # color of errors
set -U fish_color_escape yellow # color of escape codes (\n, \x2d, etc.)
set -U fish_color_operator blue # expansion operators (~, *)
set -U fish_color_quote yellow # quoted expressions (ls >"/tmp/test dir"<)
set -U fish_color_redirection blue # redirection operators (|, >, etc.)
set -U fish_color_cancel 333 brblack # sigint (cancel current comment) at prompt (^C)
set -U fish_color_autosuggestion 666 brblack # as-you-type suggestions
set -U fish_color_match blue # matching parens and the like
set -U fish_color_search_match white\x1e\x2d\x2dbackground\x3d333 # selected pager item
set -U fish_color_selection blue # vi mode visual selection (only fg)
set -U fish_color_valid_path yellow # if an argument is a valid path (only -u?)
set -U fish_color_comment 666 brblack # comments like this one!

# pager shown when completing
set -U fish_pager_color_completion white # main color for pager
set -U fish_pager_color_description magenta # color for meta description
set -U fish_pager_color_prefix blue # the string being completed
set -U fish_pager_color_progress white\x1e\x2d\x2dbackground\x3d333 # status indicator at the bottom
# set -U fish_pager_color_secondary \x2d\x2dbackground\x3d181818 # alternating rows
