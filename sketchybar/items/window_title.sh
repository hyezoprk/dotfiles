#!/bin/bash

window_title=(
  update_freq=0
  label.font="$TEXT_FONT:Regular:18.0"
  label.padding_left=-5
  script="$PLUGIN_DIR/window_title.sh"
)

sketchybar --add item window_title left                  \
           --set window_title "${window_title[@]}"       \
           --subscribe window_title front_app_switched   \
           --subscribe window_title window_focus         \
           --subscribe window_title title_change         \
