#! /bin/bash

a=$(($RANDOM%1000+1))

printf "Try to guess the number I thought!\n\n"

echo -n "Choose a number (1 to 1000): " 
read x

if [ "$x" -ne "$a" ]; then
	until [ "$x" -eq "$a"  ]; do
		if [ "$x" -gt "$a" ]
		then
			printf " My number is lower than %d\n" $x
		else
			printf " My number is higher than %d\n" $x
		fi 
		echo -n "Choose a number (1 to 1000): "
		read x
	done
fi

printf "\nCongratulations, you guessed correctly\n"
