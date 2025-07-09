#!/bin/bash

slack=(
  update_freq=1800
  script="$PLUGIN_DIR/slack.sh"
  icon.font="$FONT:Regular:14.0"
)

sketchybar --add item slack right        \
           --set slack "${slack[@]}"     \
           --subscribe slack system_woke
