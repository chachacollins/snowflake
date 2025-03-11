#!/bin/sh
# Get default sink volume and mute status
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')
MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -oE '\[MUTED\]')

# Set icons based on volume level
if [[ -n "$MUTED" ]]; then
    ICON=""  # Muted icon
    VOLUME="Muted"
elif (( $(echo "$VOLUME < 30" ) )); then
    ICON=""  # Low volume
elif (( $(echo "$VOLUME < 70" ) )); then
    ICON=""  # Medium volume
else
    ICON=""  # High volume
fi

echo "Vol: $VOLUME%"
