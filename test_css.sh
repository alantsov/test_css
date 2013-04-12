#!/bin/bash
readonly MOCK=main_redeem_mock.png
readonly GEOMETRY='782x469'
readonly X='705'
readonly Y='334'

readonly DELAY=7
readonly TEMP_DIR=~/Pictures
readonly TEMP_FILE=temp.png
readonly CROPPED_FILE=cropped_temp.png
readonly DIFF_FILE=difference.png
readonly OVERLAY_FILE=overlay.png
readonly RESULT_FILE=result.png

google-chrome $1 &
sleep $DELAY
gnome-screenshot -c
./pasteimg $TEMP_DIR/$TEMP_FILE
cd $TEMP_DIR
convert $TEMP_FILE -crop $GEOMETRY+$X+$Y $CROPPED_FILE
compare $CROPPED_FILE $MOCK $DIFF_FILE
convert $CROPPED_FILE $MOCK -compose Overlay -composite $OVERLAY_FILE
montage $CROPPED_FILE $MOCK $DIFF_FILE $OVERLAY_FILE -tile 2x2 -geometry $GEOMETRY+1+1 $RESULT_FILE
