#!/bin/sh
# Origionally by:
# Author: Marguerite Su <i@marguerite.su>
# Version: 1.0
# License: GPL-3.0
# Description: Download Bing Wallpaper of the Day and set it as your Linux Desktop.
# Switched up by:
# Author: Jeffrey Cutter

# $bing is needed to form the fully qualified URL for
# the Bing pic of the day
bing="www.bing.com"

# The mkt parameter determines which Bing market you would like to
# obtain your images from.
# Valid values are: en-US, zh-CN, ja-JP, en-AU, en-UK, de-DE, en-NZ, en-CA.
mkt="en-US"

# The idx parameter determines where to start from. 0 is the current day,
# 1 the previous day, etc.
idx="0"

# $xmlURL is needed to get the xml data from which
# the relative URL for the Bing pic of the day is extracted
xmlURL="http://$bing/HPImageArchive.aspx?format=xml&idx=$idx&n=1&mkt=$mkt"

# $saveDir is used to set the location where Bing pics of the day
# are stored.  $HOME holds the path of the current user's home directory
saveDir=$HOME'/Pictures/Bing/'

# Create saveDir if it does not already exist
mkdir -p $saveDir

# Set picture options
# Valid options are: none,wallpaper,centered,scaled,stretched,zoom,spanned
picOpts="zoom"

# The file extension for the Bing pic
picExt=".jpg"

function get_size {
#    SIZE=$(DISPLAY=:0 xdpyinfo 2> /dev/null | awk '$1=="dimensions:" {print $2}' | awk -Fx '{print $2}')
    PREFER="_1920x1080"

#    if [ -n "$SIZE" ]
#    then
#	    if [ "$SIZE" -gt 1080 ]
#	    then
#	        PREFER="_1920x1200 _1920x1080"
#	    fi
#    fi
}

# Download the highest resolution
TOMORROW=$(date --date="tomorrow" +%Y-%m-%d)
TOMORROW=$(date --date="$TOMORROW 00:10:00" +%s)
    
get_size

for picRes in $PREFER _1366x768 _1280x720 _1024x768; do

    # Extract the relative URL of the Bing pic of the day from
    # the XML data retrieved from xmlURL, form the fully qualified
    # URL for the pic of the day, and store it in $picURL
    echo "Trying to find $picRes..."
    picURL=$bing$(echo $(curl -s $xmlURL) | grep -oP "<urlBase>(.*)</urlBase>" | cut -d ">" -f 2 | cut -d "<" -f 1)$picRes$picExt

    # $picName contains the filename of the Bing pic of the day
    # This shit is confusing, and it's not working.
    #picName=${picURL#*2f}
    # This is easy to understand, and it works! -JMC 20150324
    picName=$(basename $picURL)

    # Download the Bing pic of the day
    curl -s -o $saveDir$picName $picURL

    # Test if it's a pic
    file $saveDir$picName | grep HTML > /dev/null 2>&1 && rm -rf $saveDir$picName && continue
    echo "Found $picRes..."
    break
done

# Set the GNOME3 wallpaper && # Set the GNOME 3 wallpaper picture options
DISPLAY=:0 GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.background picture-uri '"file://'$saveDir$picName'"' && DISPLAY=:0 GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.background picture-options $picOpts

if [ $? -eq 0 ]
then
  echo "Wallpaper successfully set to $picName."
  echo "$picName" > ~/var/wallpaper.current
else
  echo "Problems encountered."
fi
sleep 2
