#!/bin/sh

error_exit() {
    printf 'Exited with error:\t%s\n' "$1"
    exit 1
}

# First lets do a sanity check to make sure the files exist.
[ -f "/sys/class/power_supply/BAT0/capacity" ] || error_exit "No file /sys/class/power_supply/BAT0/capacity"

[ -f "/sys/class/power_supply/BAT0/status" ] || error_exit "No file /sys/class/power_supply/BAT0/status"

[ -f "/sys/class/power_supply/ADP1/online" ] || error_exit "No file /sys/class/power_supply/ADP1/online"

printf "File check completed\n"

while true; do
    percent="$(< /sys/class/power_supply/BAT0/capacity)"
    printf 'Pecentage: %s\n' "$percent"

    adapt="$(< /sys/class/power_supply/ADP1/online)"
printf 'Adaptor status: %s\n' "$adapt"

    case $adapt in
        0)
            printf "The adaptor is not plugged in\n"
            if [ "$percent" -lt 10 ]; then
                printf '%s\n' "The battery is less than 20%"
		sh ~/Documents/projects/batt/scripts/hiber.sh
            elif [ "$percent" -lt 50 ]; then
                printf '%s\n' "The battery is less than 50%"
            fi
            ;;
        1)
            printf "The adaptor is plugged in\n"
            ;;
        *)
            error_exit "Adaptor status check returned invalid value"
            ;;
    esac

    sleep 1
done
