#!/bin/bash

messages=(
  update_freq=60
  padding_left=10
  icon.font="$FONT:Bold:17.0"
  icon.color="$WHITE"
  label.color="$GREEN"
  label.font="$FONT:Bold:11.0"
  label.y_offset=5
  label.padding_left=-4
  label.padding_right=4
  script="$PLUGIN_DIR/messages.sh"
  click_script="open -a Messages" \
)

sketchybar -m --add item messages right           \
              --set messages "${messages[@]}"     \
              --subscribe messages system_woke

status_bracket=(
  background.color="$BACKGROUND_1"
  background.border_color="$BACKGROUND_2"
)

sketchybar --add bracket status brew github.bell wifi volume_icon slack messages \
           --set status "${status_bracket[@]}"
