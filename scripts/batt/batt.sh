#!/bin/sh

while true
do
# Check if laptop is on battery or AC power
acpower=$(acpi -a | grep -c 'on-line')

# Check battery percentage
battery_level=$(acpi -b | awk '{ print $4 }' | cut -d "%" -f1)

# If laptop is on battery and the battery level is 5%, send a popup
if [ "$acpower" -eq 0 ] && [ "$battery_level" -eq 5 ]; then
	notify-send "Battery low - 5%"
	sleep 5
	systemctl hibernate

# If laptop is on battery and the battery level is 10%, send a popup
elif [ "$acpower" -eq 0 ] && [ "$battery_level" -eq 10 ]; then
	notify-send "Battery low - 10%"

# If laptop is on battery and the battery level is 20%, send a popup
elif [ "$acpower" -eq 0 ] && [ "$battery_level" -eq 20 ]; then
	notify-send "Battery low - 20%"
fi
done
