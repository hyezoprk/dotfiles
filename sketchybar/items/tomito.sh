#!/bin/bash

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

POPUP_SCRIPT="sketchybar -m --set tomito popup.drawing=toggle"

tomito_start=(
  icon="$PLAY"
  background.height=40
  background.corner_radius=20
  width=40
  align=center
  background.color=$POPUP_BACKGROUND_COLOR
  background.border_color=$WHITE
  background.border_width=0
  background.drawing=on
  icon.padding_left=10
  updates=on
  label.drawing=off
  script="$PLUGIN_DIR/tomito.sh"
)
tomito_stop=(
  icon="$STOP"
  background.height=40
  background.corner_radius=20
  width=30
  align=center
  background.color=$POPUP_BACKGROUND_COLOR
  background.border_color=$WHITE
  background.border_width=0
  background.drawing=on
  icon.padding_left=10
  icon.padding_right=10
  updates=on
  label.drawing=off
  script="$PLUGIN_DIR/tomito.sh"
)
tomito_skip=(
  icon="$SKIP"
  background.height=40
  background.corner_radius=20
  width=35
  align=center
  background.color=$POPUP_BACKGROUND_COLOR
  background.border_color=$WHITE
  background.border_width=0
  background.drawing=on
  icon.padding_right=5
  icon.padding_left=5
  updates=on
  label.drawing=off
  script="$PLUGIN_DIR/tomito.sh"
)

tomito=(
  update_freq=1
  icon.padding_left=0
  icon.padding_right=0
  label.font="$TEXT_FONT:Regular:23.0"
  label.color="$GREEN"
  label.y_offset=-1
  width=70
  background.drawing=on
  background.height=33
  background.corner_radius=15
  background.border_width=1
  background.border_color=$WHITE
  popup.horizontal=on
  popup.align=center
  popup.height=50
  click_script="$POPUP_SCRIPT"
  script="$PLUGIN_DIR/tomito.sh"
)

sketchybar --add item tomito center                                 \
           --set tomito "${tomito[@]}"                              \
           --subscribe tomito system_woke mouse.entered             \
                              mouse.exited mouse.exited.global      \
                                                                    \
           --add item tomito.start popup.tomito                     \
           --set tomito.start "${tomito_start[@]}"                  \
           --subscribe tomito.start mouse.clicked                   \
                                                                    \
           --add item tomito.stop popup.tomito                      \
           --set tomito.stop "${tomito_stop[@]}"                    \
           --subscribe tomito.stop mouse.clicked                    \
                                                                    \
           --add item tomito.skip popup.tomito                      \
           --set tomito.skip "${tomito_skip[@]}"                    \
           --subscribe tomito.skip mouse.clicked