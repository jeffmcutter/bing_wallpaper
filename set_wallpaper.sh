#!/bin/sh
# Origionally developed as bing_wallpaper.sh by:
# Author: Marguerite Su <i@marguerite.su>
# Version: 1.0
# License: GPL-3.0
# Description: Download Bing Wallpaper of the Day and set it as your Linux Desktop.
# Modified to just set wallpaper passed as arg by Jeffrey Cutter.

function usage {
  print "USAGE: $(basename $0) picture_location"
  exit 1
}

if [ $# -ne 1 ]
then
  usage
fi

if [ ! -r "$1" ]
then
  usage
fi

file=$(realpath $1)

picOpts="zoom"


# Set the GNOME3 wallpaper && # Set the GNOME 3 wallpaper picture options
DISPLAY=:0 GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.background picture-uri '"file://'$file'"' && DISPLAY=:0 GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.background picture-options $picOpts

if [ $? -eq 0 ]
then
  picName=$(basename $file)
  echo "Wallpaper successfully set to $picName."
  echo $picName > ~/var/wallpaper.current
else
  echo "Something went wrong..."
  exit 1
fi
