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
		for i in $(find /{,s}bin /usr/{,s}bin -type f,l)
		do
			TOCHECK=$(grep ".*\ $i$" syssum | sed -E "s/.*\ \ //")
			SUM=$(grep ".*\ $i$" syssum | sed -E "s/\ .*//")
			if [[ $i == $TOCHECK ]]
			then
				if [[ $(sha512sum "$TOCHECK" | sed -E "s/\ .*//") == $SUM ]]
				then
					echo "$TOCHECK check [OK]"
				else
					echo "$TOCHECK check [FAILED]" | tee -a failed
				fi
			else	
				echo "$i [FAILED] file was not in our database " | tee -a failed
			fi
		done 
		if [[ -f failed ]]
		then
			echo -e "\n########### Failed #########\n"
			cat failed
		fi
	fi
fi
