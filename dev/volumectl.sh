#!/bin/sh

# A dmenu wrapper script for system functions.

case "$(printf "+ Increase\n- Decrease" | dmenu -l 20 -i -p 'Action: ')" in
	'+ Increase') pactl set-sink-volume 0 +10% ;;
	'- Decrease ') pactl set-sink-volume 0 -10% ;;
	*) exit 1 ;;
esac
