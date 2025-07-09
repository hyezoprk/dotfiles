#!/bin/bash

LAYOUT="$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep "KeyboardLayout Name" | cut -c 33- | rev | cut -c 2- | rev)"

# specify short layouts individually.
case "$LAYOUT" in
  "ABC") SHORT_LAYOUT="ABC";;
  *) SHORT_LAYOUT="한";;
esac

sketchybar --set $NAME label="$SHORT_LAYOUT"

