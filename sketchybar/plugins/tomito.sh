#!/bin/bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

TIME=$(osascript -e 'tell application "Tomito" to getRemainingTime')
TYPE=$(osascript -e 'tell application "Tomito" to getCurrentActivityType')
COLOR=""

tomito () {
  osascript -e "tell application \"Tomito\" to $1"
}

popup () {
  sketchybar --set tomito popup.drawing=$1
}

formatTimeToMinutes() {
  local time_string="$1"
  date -j -f "%H:%M" "$time_string" "+%s"  # macOS syntax, use date on Linux
}

NOW=$(formatTimeToMinutes "$TIME")
BREAK_TIME=$(formatTimeToMinutes "5:00")

update () {
  case "$TYPE" in
    "Break")
      if [ "$NOW" -gt "$BREAK_TIME" ]; then
        COLOR="$BLUE"
      else
        COLOR="$GREEN"
      fi
      ;;
    "Session")
      if [ "$NOW" -gt "$BREAK_TIME" ]; then
        COLOR="$ORANGE"
      else
        COLOR="$RED"
      fi
      ;;
    *)
      COLOR="$WHITE"
      ;;
  esac

  sketchybar --set tomito label="$TIME"                          \
                          label.color="$COLOR"                   \
                          background.border_color="$COLOR"
}

mouse_clicked () {
  case "$NAME" in
    "tomito.start") tomito start; popup off
    ;;
    "tomito.stop") tomito stop; popup off
    ;;
    "tomito.skip") tomito skip; popup off
    ;;
    *) exit
    ;;
  esac
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  "mouse.entered") popup on
  ;;
  "mouse.exited"|"mouse.exited.global") popup off
  ;;
  "routine") update
  ;;
  *) exit
  ;;
esac
