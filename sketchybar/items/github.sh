#!/bin/bash

POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

github_bell=(
  padding_right=2
  update_freq=180
  icon=$BELL
  icon.font="$FONT:Bold:15.0"
  icon.color=$ORANGE
  label=$LOADING
  label.highlight_color=$ORANGE
  popup.align=center
  popup.y_offset=3
  script="$PLUGIN_DIR/github.sh"
  click_script="$POPUP_CLICK_SCRIPT"
)

github_template=(
  drawing=off
  background.corner_radius=12
  icon.font="$FONT:Bold:11.0"
  label.font="$FONT:Bold:11.0"
  label.padding_left=10
  padding_left=8
  padding_right=12
  icon.background.height=2
  icon.background.y_offset=-12
)

sketchybar --add event github.update                    \
           --add item github.bell right                 \
           --set github.bell "${github_bell[@]}"        \
           --subscribe github.bell  mouse.entered       \
                                    mouse.exited        \
                                    mouse.exited.global \
                                    system_woke         \
                                    github.update       \
                                                        \
           --add item github.template popup.github.bell \
           --set github.template "${github_template[@]}"
