#!/bin/bash
# save the sum of binary

### How to use ####

# to save :
# ./systemchecksum.sh save 
# 
# to check : 
# ./systemchecksum.sh check


#### save sum of files #####

if [[ $1 == "save" ]]
then
	{ sha512sum /usr/{s,}bin/* ;sha512sum /{s,}bin/* ;} > syssum 2>/dev/null
fi

if [[ $1 == "check" ]]
then
	if [[ -f syssum ]]
	then
		while read file
		do
			TOCHECK=$(echo "$file" | sed -E "s/.*\ //")
			SUM=$(echo "$file" | sed -E "s/\ .*//")
			if [[ $(sha512sum "$TOCHECK" | sed -E "s/\ .*//") == $SUM ]]
			then
				echo "$TOCHECK [OK]"
			else
				echo "$TOCHECK [FAILED]" | tee -a failed
			fi
		done < syssum
		if [[ -f failed ]]
		then
			echo -e "\n########### Failed #########\n"
			cat failed
		fi
	fi
fi
