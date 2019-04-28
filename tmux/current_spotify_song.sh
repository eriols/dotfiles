#!/usr/bin/env osascript
# copied from https://github.com/sbernheim4/dotfiles/blob/master/tmux_scripts/music.sh
# Returns the current playing song in Spotify for OSX

tell application "Spotify"
if it is running then
	if player state is playing then
		set track_name to name of current track
		set artist_name to artist of current track

		if artist_name > 0
			# If the track has an artist set and is therefore most likely a song rather than an advert
			set t to "♫ " & artist_name & " - " & track_name

			if length of t > 40
				text 1 thru 40 of t & "..."
			else
				"♫ " & artist_name & " - " & track_name
			end if
		else
			# If the track doesn't have an artist set and is therefore most likely an advert rather than a song
			"~ " & track_name
		end if
	end if
end if
end tell
