#!/bin/bash

# Get a random existing Bing wallpaper.

FILE=$(choose_random_file_from_dir.rb ~/Pictures/Bing)

set_wallpaper.sh $FILE

sleep 2
