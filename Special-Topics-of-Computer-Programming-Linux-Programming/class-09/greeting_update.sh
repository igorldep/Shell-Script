#! /bin/bash

name=$(cat /etc/passwd | grep $(whoami) | awk -F":" '{print $5}')
hour=$(date | awk -F " " '{print $4}' | awk -F ":" '{print $1}')
min=$(date | awk -F " " '{print $4}' | awk -F ":" '{print $2}')

if [ $hour -le 12 ]; then
	if [ $hour -eq 12 ]; then
		if [ $min -gt 0 ]; then
			str="Boa tarde"
		else
			str="Bom dia"
		fi
	else
		str="Bom dia"
	fi
else #maior que 12
	if [ $hour -le 18 ]; then
		if [ $hour -eq 18 ]; then
			if [ $min -eq 0 ]; then
				str="Boa tarde"
			else
				str="Boa noite"
			fi
		else
			str="Boa tarde"		
		fi
	else
		str="Boa noite"
	fi
fi

echo "$str $name, seja bem-vindo."
