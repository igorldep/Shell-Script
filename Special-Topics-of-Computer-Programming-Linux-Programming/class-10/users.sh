#! /bin/bash

for i in $(cat /etc/passwd | wc -l); do
	users=$(cat /etc/passwd | cut -f 1 -d ":")
	echo "User $i: $users";
done
