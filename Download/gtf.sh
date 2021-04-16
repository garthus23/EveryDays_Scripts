#!/bin/bash

#################################################
#						#
#  download Eztv Torrent File 			#
#						#
#   $1 - the TV Show 				#
#						#
#						#
#################################################

# Retrieve and format the Episode List

EP=$(curl -s https://eztv.re/search/"$1" | grep "$1" | sed "s/.*title=\"//g" | grep "\[eztv\]" | sed "s/\ \[eztv\].*$/\[eztv.re\].mkv/" | grep 264 | sed -e "s/\s/\./g" | sort -n) 

# print the episode List

i=1
for VAL in $EP
do
	echo "$i - $VAL"
	i=$((i+1))
done
echo ''
read -rp "Wich Episode ?: " CHOOSED
echo ''
EPCHOOSED=$(echo $EP | cut -d " " -f $CHOOSED)
echo "$EPCHOOSED"

# Download the .torrent file
curl -sgO "https://zoink.ch/torrent/$EPCHOOSED.torrent"
