#!/bin/bash

SPACE_ICONS=("main" "devs" "docs")

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))

  space=(
    space=$sid
    icon="${SPACE_ICONS[i]}"
    icon.padding_left=10
    icon.padding_right=5
    icon.font="$TEXT_FONT:Regular:18.0"
    icon.highlight_color="$ORANGE"
    # icon.y_offset=1
    padding_left=2
    padding_right=2
    label.padding_right=20
    label.color="$GREY"
    label.highlight_color="$WHITE"
    label.font="sketchybar-app-font:Regular:15.0"
    label.y_offset=-2
    background.color="$BACKGROUND_1"
    background.border_color="$BACKGROUND_2"
    script="$PLUGIN_DIR/space.sh"
  )

  sketchybar --add space space.$sid left    \
             --set space.$sid "${space[@]}" \
             --subscribe space.$sid mouse.clicked
done

space_creator=(
  icon=􀆊
  icon.font="$FONT:Heavy:10.0"
  padding_left=8
  padding_right=3
  label.drawing=off
  display=active
  click_script='yabai -m space --create'
  script="$PLUGIN_DIR/space_windows.sh"
  icon.color=$WHITE
)

sketchybar --add item space_creator left               \
           --set space_creator "${space_creator[@]}"   \
           --subscribe space_creator space_windows_change
