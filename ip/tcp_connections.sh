#!/bin/bash
# monitor tcp connections

# The goal is to create a file and write the remote connected Ip
# using the ss command 
# display the number of connection since the beginning of the script 
# we will have a classement with the most connected ip
# In my example ip are added to the file every 30s for 10min


LOOP=20  # number of the loop
TIME=30s # sleep time between refreshment

if [[ -f ipfile ]]
then
	rm ipfile
fi

i=0
while [[ $i != "$LOOP" ]]
do
	clear
	ss -latupen | tail -n +2 | sed -E 's/(users|timer).*$//' | sed -E 's/^.*\:[0-9]{5}\ *//' | grep -v '0.0.0.0:*' >> ipfile
	((i += 1));
	< ipfile sort -n | uniq -c | sort -nr | sed s/\ *//
	sleep $TIME
done
rm ipfile
