#!/usr/bin/env bash

source "$DOTFILES_PATH/variables.bash"

# This defines this module's priority, determining where it will be rendered on
# the bar relative to other modules.
PRIORITY=2500

# This is the trigger that the incoming line from the FIFO must match in order
# to be processed by this module.
MATCH_PREFIX="BM_EXAMPLE"
MATCH="$MATCH_PREFIX*"

# Define the function that will be called upon the match being triggered. This
# should process the first argument (the line from the FIFO) and echo the
# desired bar output.
bar_module_example() {
  # Write the line from the 10th character (cutting off the MATCH_PREFIX) with
  # lemonbar's left-align delimiter.
  echo -e "%{l}${1:10}"
}

# Export our function so that the formatter script can call it.
export -f bar_module_bspwm

# Call this handy function for adding the various thing we declared to the
# MODULE_ variables that the formatter script uses.
register_bar_module "$PRIORITY" "$MATCH" "bar_module_example"

# Create a function that will periodically write to the FIFO with the correct
# prefix, thereby updating the module.
bar_module_example_updater() {
  while [ $BAR_RUNNING -eq 1 ]; do
    echo -e "$MATCH_PREFIX""$(date +%H.%M)" > "$BAR_FIFO"
    sleep 30
  done
}

# Fork that function to a background process.
bar_module_clock_updater &

# Optional: Initialize that module by immediately writing to the FIFO using your
# prefix to show some default information on the bar when it loads.
echo -e "$MATCH_PREFIX"Loading... > "$BAR_FIFO"

