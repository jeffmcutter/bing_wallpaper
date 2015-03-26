#!/bin/bash

FAVORITES_FILE=~/var/wallpaper.favorites
CURRENT_FILE=~/var/wallpaper.current

touch $FAVORITES_FILE

FAVORITES=$(cat $FAVORITES_FILE $CURRENT_FILE | sort -u)

> $FAVORITES_FILE

for i in $FAVORITES
do
  echo $i >> $FAVORITES_FILE
done
