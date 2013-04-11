#!/bin/bash
readonly MOCK=~/Pictures/redeem_mock.png
readonly GEOMETRY='601x428'

google-chrome $1 &
sleep 7
gnome-screenshot -c
./pasteimg ~/Pictures/temp.png
convert ~/Pictures/temp.png -crop $GEOMETRY+706+334 ~/Pictures/cropped_temp.png
compare ~/Pictures/cropped_temp.png $MOCK ~/Pictures/difference.png
convert ~/Pictures/cropped_temp.png $MOCK -compose Overlay   -composite ~/Pictures/overlay.png
cd ~/Pictures
montage cropped_temp.png $MOCK difference.png overlay.png -tile 2x2 -geometry $GEOMETRY+1+1 result.png
