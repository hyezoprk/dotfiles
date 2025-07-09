#!/bin/bash

empty=(
  padding_right=10
  padding_left=0
  label.padding_right=0
  label.padding_left=0
  icon.padding_right=0
  icon.padding_left=0
)

sketchybar --add item empty right       \
           --set empty "${empty[@]}" \
           --subscribe empty system_woke
