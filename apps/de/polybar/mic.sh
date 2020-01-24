#!/usr/bin/env sh

pidfile="/var/run/user/$(id -u)/polybar-mic-script.sh.pid"

if [ -e "$pidfile" ]; then
	kill "$(cat "${pidfile}")" > /dev/null 2>&1
	cleanup
fi

cleanup() {
	rm -f "$pidfile"
}

print_status() {
	if amixer get Capture | grep -q '\[off\]'; then
		# red means recording
		echo "%{F$(xrdb -query | grep -Po 'color4:.*#\K\w[0-9a-f]+')}"
	else
		# blue means nobody can hear you scream
		echo "%{F$(xrdb -query | grep -Po 'color1:.*#\K\w[0-9a-f]+')}"
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
