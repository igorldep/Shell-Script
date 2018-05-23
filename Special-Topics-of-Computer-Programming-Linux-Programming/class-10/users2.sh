#! /bin/bash

for (( i=1; i<=$(cat /etc/passwd | wc -l); i++ )); do
	aux="head -$i"
	user=$(cat /etc/passwd | cut -f 1 -d ":" | "$aux")
	echo "User $i: $user";
done
