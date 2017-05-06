#!/bin/bash

# Get a random existing Bing wallpaper.

PATH=$PATH:$HOME/bin

PIC=$(choose_random_line_from_file.rb ~/var/wallpaper.favorites)
DIR=~/Pictures/Bing
FILE=$DIR/$PIC

if [ -r "$FILE" ]
then
  set_wallpaper.sh $FILE
else
  echo "$FILE not found."
fi

sleep 2
