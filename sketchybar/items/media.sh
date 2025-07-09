media=(
  icon.background.drawing=on
  icon.background.image=media.artwork
  icon.background.image.corner_radius=9
  icon.background.image.scale=0.85
  script="$PLUGIN_DIR/media.sh"
  label.max_chars=20
  label.padding_left=5
  label.font="$TEXT_FONT:Regular:15.0"
  label.color="$YELLOW"
  scroll_texts=on
  updates=on
)

sketchybar --add item media right       \
           --set media "${media[@]}"      \
           --subscribe media media_change
