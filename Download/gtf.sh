#!/bin/bash

#################################################
#						#
#  download Eztv Torrent File 			#
#						#
#   $1 - the TV Show 				#
#						#
#						#
#################################################

 
EP=$(curl -s https://eztv.re/search/$1 | grep $1 | sed "s/.*title=\"//g" | grep "\[eztv\]" | sed "s/\ \[eztv\].*$/\[eztv.re\].mkv/" | grep 264 | sed -e "s/\s/\./g")
i=1

for VAL in $EP
do
	echo "$i - $VAL"
	i=$((i+1))
done
echo ''
read -p "Wich Episode Do you Want ?: " CHOOSED
echo ''
EPCHOOSED=$(echo $EP | cut -d " " -f $CHOOSED)
echo $EPCHOOSED
