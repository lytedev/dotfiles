0. You will need npm, mpd, and ncmpcpp.

1. Create a file in the following format named "creds" in this directory:

  email=REPLACEWITHyouremail@google.com
  password=REPLACEWITHyour-app-specific-password
  device-id=54bbd32a309a34ef
  extended-m3u=true
  daemon=true

2. Run "./setup.sh"

3. Run "mpd"

4. Run "GMusicProxy"

5. Run "./fetch_playlists.sh"

  Note: If you want, you can pass the previous script the name of a specific
  playlist to fetch just the one you want.

6. Now we can actually play our playlists!

  gmusic-mpd -d ~/.config/mpd/playlists/ -r "YOUR_PLAYLIST_NAME"

  Note: You should make this an alias!

TODO: Create an alias that fires up a default pre-config'd playlist by init'ing
everything and BOOM!

