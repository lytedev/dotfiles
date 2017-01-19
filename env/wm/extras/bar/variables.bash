#!/usr/bin/env bash

# the path to the bar stuff
export BAR_PATH="$DOTFILES_PATH/env/wm/extras/bar"

# where to put the file that contains the bar's pid
export BAR_PID_FILE="$BAR_PATH/wm_bar.pid"

# whether or not to start the bar when X starts
export BAR_ON_XINIT=1

# the path to the bar's FIFO
export BAR_FIFO="$BAR_PATH/wm_bar_fifo.lock"

# the monitor on which to display the bar (see BSPWM(1))
export BAR_MONITOR=0 # detect monitor automatically

# the bar's log file
export BAR_LOG="$BAR_PATH/wm_bar.log"

# whether or not the bar is anchored to the top of the monitor (or the bottom if
# not)
export BAR_TOP=0

# the pixel height of the bar
export BAR_HEIGHT=24

# the bar's underline line width
export BAR_BORDER_WIDTH=0

# the bar's font
export BAR_FONT_FAMILY="$PRIMARY_FONT_FAMILY_WITH_SIZE"

# whether or not the "underline" appears above or below the desktop names on
# lemonbar
export BAR_UNDERLINE=0

# the bar's spacing on the left and right sides
export BAR_MARGIN=0
# export BAR_MARGIN=$WINDOW_GAP

# how far left the display the bar note that the margin will be used to attempt
# to center the bar on the monitor it is being displayed on
export BAR_OFFSET=0

# the window ID to give to bar so that other scripts may raise or lower it in
# bspwm
export BAR_WID="wmpanel"

# the amount of pixel padding space to place above the bar
export BAR_TOP_PADDING=0

# the amount of pixel padding space to place below the bar
export BAR_BOTTOM_PADDING=24

# the characters to always print on the left-most side of the bar
export BAR_LEFT_CHARS=""

# the characters to always print on the right-most side of the bar
export BAR_RIGHT_CHARS=" "
