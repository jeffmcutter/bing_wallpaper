#!/bin/bash

# Get a random existing Bing wallpaper.

PATH=$PATH:$HOME/bin

FILE=$(choose_random_file_from_dir.rb ~/Pictures/Bing)

set_wallpaper.sh $FILE

sleep 2
