#!/bin/sh

# This script will put your laptop to sleep when the lid is closed

while true
do
# Get the current status of the lid
lid_status=$(cat /proc/acpi/button/lid/LID0/state | awk '{print $2}')

# If the lid is currently closed, put the laptop to sleep
if [ "$lid_status" == "closed" ]; then
	systemctl suspend && slock loginctl
fi
done
