#!/bin/bash

source "$CONFIG_DIR/colors.sh"

COUNT="$(brew outdated | wc -l | tr -d ' ')"
COLOR="$RED"

case "$COUNT" in
  [3-5][0-9]) COLOR="$MAUVE"
  ;;
  [1-2][0-9]) COLOR="$LAVENDER"
  ;;
  [1-9]) COLOR="$PINK"
  ;;
  0) COLOR="$GREEN"
     COUNT=􀆅
  ;;
esac

sketchybar --set $NAME label="$COUNT" icon.color="$COLOR"