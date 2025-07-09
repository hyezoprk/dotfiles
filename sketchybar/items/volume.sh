#!/bin/bash

volume_slider=(
  script="$PLUGIN_DIR/volume.sh"
  updates=on
  label.drawing=off
  icon.drawing=off
  slider.highlight_color=$SAPPHIRE
  slider.background.height=5
  slider.background.corner_radius=3
  slider.background.color=$BACKGROUND_2
  slider.knob=􀀁
  slider.knob.drawing=on
)

volume_icon=(
  click_script="$PLUGIN_DIR/volume_click.sh"
  icon.width=0
  icon.align=left
  padding_right=-1
  icon.color=$SAPPHIRE
  icon.font="$FONT:Regular:14.0"
  label.color=$SAPPHIRE
  label.width=25
  label.align=left
  label.font="$FONT:Regular:14.0"
)

sketchybar --add slider volume right               \
           --set volume "${volume_slider[@]}"      \
           --subscribe volume volume_change        \
                              mouse.clicked        \
                                                   \
           --add item volume_icon right            \
           --set volume_icon "${volume_icon[@]}"
