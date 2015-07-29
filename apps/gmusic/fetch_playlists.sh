#!/usr/bin/env bash

filename="playlists_data.tmp"
curl 127.0.0.1:9999/get_all_playlists | tail -n +2 | awk '{getline b;printf("%s %s\n",$0,b)}' | sed 's/.*,//' > "$filename"
while read -r line
do
  url=${line##* }
  title=${line% *}
  if [ -z "$1" ]; then
    echo "Getting playlist $title from $url"
    curl "$url" > "$HOME/.config/mpd/playlists/$title.m3u"
  fi
  if [[ ${1,,} == ${title,,} ]]; then
    echo "Getting playlist $title from $url"
    curl "$url" > "$HOME/.config/mpd/playlists/$title.m3u"
  fi
done < "$filename"
rm "playlists_data.tmp"
