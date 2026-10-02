#!/bin/sh
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
MUTED=$(echo "$VOLUME" | grep -oE '\[MUTED\]')
PERCENT=$(echo "$VOLUME" | grep -oE '[0-9]+(\.[0-9]+)?' | head -1)

if [ -n "$MUTED" ]; then
    echo "  muted"
else
    echo " "
fi
