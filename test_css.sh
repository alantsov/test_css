#!/bin/bash
readonly DELAY=7
readonly TEMP_DIR=~/Pictures
readonly TEMP_FILE=temp.png
readonly CROPPED_FILE=cropped_temp.png
readonly DIFF_FILE=difference.png
readonly OVERLAY_FILE=overlay.png

for config in "$@"; do
  source $config
  google-chrome $URL &
  sleep $DELAY
  gnome-screenshot -c
  ./pasteimg $TEMP_DIR/$TEMP_FILE
  current_dir=$PWD
  cd $TEMP_DIR
  convert $TEMP_FILE -crop $GEOMETRY+$X+$Y $CROPPED_FILE
  compare $CROPPED_FILE $MOCK $DIFF_FILE
  convert $CROPPED_FILE $MOCK -compose Overlay -composite $OVERLAY_FILE
  montage $CROPPED_FILE $MOCK $DIFF_FILE $OVERLAY_FILE -tile 2x2 -geometry $GEOMETRY+1+1 $RESULT_FILE
  cd $current_dir
done

cd $TEMP_DIR
rm $TEMP_FILE
rm $CROPPED_FILE
rm $DIFF_FILE
rm $OVERLAY_FILE
