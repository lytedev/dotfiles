#!/usr/bin/env bash

source "$DOTFILES_PATH/variables.bash"

# export BAR_LOG="$PWD/bar.log"
# echo -e "BEGIN BAR LOG\n" > "$BAR_LOG"

reload_colors() {
	source "$BAR_PATH/colors.bash"
}

# trap reload_colors SIGUSR1

LAUNCHER_BUTTONS="%{F$COLOR_DARK}%{A3:launcher2:}%{A:launcher:}!%{A}%{A} %{A3:close:}%{A:kill:}X%{A}%{A}%{F-}"

export MODULE_MATCH=()
export MODULE_CALLBACK=()
export MODULE_DATA=()
export MODULE_CONTENT=()
export MODULE_INIT=()
export MODULE_PIDS=""

register_bar_module() {
  MODULE_MATCH[$1]=$2
  MODULE_CALLBACK[$1]=$3
  MODULE_DATA[$1]=
  MODULE_CONTENT[$1]=
  MODULE_INIT[$1]=$4
	${MODULE_INIT[$1]} &
	PID=$!
	echo $PID > "$BAR_PATH/modules/$3.pid"
  echo -e "Registered Bar Module: $1 $2 $3 $4 with PID $PID" >> "$BAR_LOG"
}
export -f register_bar_module

for f in "$BAR_PATH/modules/"*-bm.bash; do
  echo -e "$f" >> "$BAR_LOG"
	for bl in "$BLACKLISTED_BAR_MODULES"; do
		if [[ "$f" = "$BAR_PATH/modules/"$bl-bm.bash ]]; then
			f=""
		fi
	done
	if [[ -n $f ]]; then
		source "$f"
	fi
done

while read -r line; do
  # echo -e "Bar Line: $line" >> "$BAR_LOG"
  for i in ${!MODULE_MATCH[@]}; do
		echo ${!MODULE_MATCH[@]} >> $BAR_LOG
    if [[ $line == ${MODULE_MATCH[$i]} ]]; then
      echo -e "Bar Module Update: [$i] Matched ${MODULE_MATCH[$i]} with $line" >> "$BAR_LOG"
      MODULE_CONTENT[$i]="$("${MODULE_CALLBACK[$i]}" "$line")"
      # echo -e "New Module Content: "${MODULE_CONTENT[$i]} >> "$BAR_LOG"
    fi
  done

  l_content=""
  c_content=""
  r_content=""
  for i in ${!MODULE_CONTENT[@]}; do
    if [ $i -ge 30000 ]; then
      r_content="$r_content ${MODULE_CONTENT[$i]}"
    elif [ $i -ge 20000 ]; then
      c_content="$c_content${MODULE_CONTENT[$i]} "
    else
      l_content="$l_content${MODULE_CONTENT[$i]} "
    fi
  done

  printf "%s\n" "%{l} $l_content $LAUNCHER_BUTTONS %{c}$c_content %{r}$r_content "
done

# echo -e "\nEND BAR LOG" >> "$BAR_LOG"

