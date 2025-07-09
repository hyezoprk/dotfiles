#!/bin/bash

keyboard=(
    icon.drawing=off
    label.font="$TEXT_FONT:Regular:13.0"
    script="$PLUGIN_DIR/keyboard.sh"
)

sketchybar --add item keyboard right        \
           --set keyboard "${keyboard[@]}"  \
           --add event keyboard_change "AppleSelectedInputSourcesChangedNotification" \
           --subscribe keyboard keyboard_change