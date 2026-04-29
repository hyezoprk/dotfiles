#!/bin/bash
if [ $(( $(date +%S) % 2 )) -eq 0 ]; then
    date +"%y%m%d %H:%M"
else
    date +"%y%m%d %H %M"
fi
