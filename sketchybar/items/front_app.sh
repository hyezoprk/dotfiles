#!/bin/bash

front_app=(
  # label.font="$FONT:Regular:12.0"
  icon.background.drawing=on
  label.padding_right=0
  display=active
  script="$PLUGIN_DIR/front_app.sh"
  click_script="open -a 'Mission Control'"
)

sketchybar --add item front_app left         \
           --set front_app "${front_app[@]}" \
           --subscribe front_app front_app_switched
