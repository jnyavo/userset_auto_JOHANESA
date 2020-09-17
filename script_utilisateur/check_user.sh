#!/bin/bash


if [ $# -ne 1 ]
then
	echo "Specifier le fichier xls en argument positionel comme suit"
	echo "$0 <fichier.xls>"
	exit 99
fi



USERS=( 0 )


#Prendre la liste des users et mettre dans l'array USERS

index=0

while IFS=: read -r username _ _ _ _ dir _
do
    USERS[$index]=$username
    index=$(($index+1))
done <<<$(grep /home /etc/passwd | sort -t: -k6 )





INPUT=$1
PASS_PAR_DEFAUT=mtdepass123

OLDIFS=$IFS
IFS=','
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read nom prenom username
do
        if [[ "${username:1:-1}"  = "username" ]] || [ -z  "${username:1:-1}" ]
	then
		continue
	fi

	#Verification si le username est déjà inscrit 

	if [[ " ${USERS[@]} " =~ " ${username:1:-1} " ]];
	then
		echo "${username:1:-1} est déjà inscrit."
	else
		echo "inscription de ${username:1:-1}."
		sudo useradd "${username:1:-1}" --create-home
		echo "${username:1:-1}":${PASS_PAR_DEFAUT} | sudo chpasswd
	fi

done <<<$(xls2csv ${INPUT})
IFS=$OLDIFS




