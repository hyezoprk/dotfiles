#!/usr/bin/env bash

disk=(
	update_freq=6000
	icon="$DISK"
	icon.font="$FONT:Bold:16"
	icon.color="$MAROON"
	label.font="$TEXT_FONT:Regular:13.0"
	label.color="$WHITE"
	label.padding_right=10
	script="$PLUGIN_DIR/disk.sh"
)

sketchybar --add item disk right 		\
					 --set disk "${disk[@]}"

memory=(
	update_freq=10
	icon="$MEMORY"
	icon.font="$FONT:Bold:16"
	icon.padding_left=10
	icon.color="$GREEN"
  label.font="$TEXT_FONT:Regular:13.0"
	label.color="$WHITE"
	script="$PLUGIN_DIR/ram.sh"
)

sketchybar 	--add item memory right 		\
						--set memory "${memory[@]}"

stats_bracket=(
  background.color="$BACKGROUND_1"
  background.border_color="$BACKGROUND_2"
	
)

sketchybar --add bracket stats disk memory     \
           --set stats "${stats_bracket[@]}"
