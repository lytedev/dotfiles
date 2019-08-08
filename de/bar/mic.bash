#!/usr/bin/env bash

pidfile="/var/run/user/$UID/polybar-mic-script.pid"

if [ -e "$pidfile" ]; then
	kill "$(cat "${pidfile}")" > /dev/null 2>&1
	cleanup
fi

cleanup() {
	rm -f "$pidfile"
}

print_status() {
	if amixer get Capture | grep -q '\[off\]'; then
		echo ""
	else
		echo " "
	fi
}

toggle() {
	amixer set Capture toggle > /dev/null 2>&1
	print_status
}

trap "cleanup" EXIT
trap "toggle" USR1

echo $$ > "$pidfile"

while true; do
	print_status
	sleep 1 &
	wait
done
