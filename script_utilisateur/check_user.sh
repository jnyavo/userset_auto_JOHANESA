#!/bin/bash

arrVar=( 0 )

index=0


while IFS=: read -r username _ _ _ _ dir _
do
    arrVar[$index]=$username
    echo ${arrVar[$index]}
    index=$(($index+1))
done <<<$(grep /home /etc/passwd | sort -t: -k6 )




INPUT=test.csv
OLDIFS=$IFS
IFS=','
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read nom prenom username
do
        if ["$username" == "username"]
	then
		continue
	fi

	if [$username in $arrVar]
	then
		echo "yes"
	else
		echo $username
	fi

done < $INPUT
IFS=$OLDIFS


