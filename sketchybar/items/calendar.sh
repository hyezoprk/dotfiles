#!/bin/bash

calendar=(
  update_freq=30
  padding_left=12
  icon=""
  icon.color=$MAGENTA
  icon.y_offset=1
  icon.padding_left=10
  icon.padding_right=-3
  label.font="$TEXT_FONT:Regular:14.0"
  label.align=right
  label.y_offset=-1
  label.padding_left=10
  label.padding_right=10
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  script="$PLUGIN_DIR/calendar.sh"
  click_script="$PLUGIN_DIR/zen.sh"
)

sketchybar --add item calendar right       \
           --set calendar "${calendar[@]}" \
           --subscribe calendar system_woke
