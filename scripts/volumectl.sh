#!/bin/sh

# A dmenu wrapper script for system functions.

case "$(printf "+ Increase\n- Decrease\nMute" | dmenu -l 20 -i )" in
	'+ Increase') pactl set-sink-volume 0 +10% ;;
	'- Decrease') pactl set-sink-volume 0 -10% ;;
	'Mute') pactl set-sink-mute 0 toggle ;;
	*) exit 1 ;;
esac
