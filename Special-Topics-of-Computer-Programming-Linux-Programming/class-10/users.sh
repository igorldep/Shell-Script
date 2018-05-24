#! /bin/bash

max=$(id -u)

for i in $(seq 1 $max); do
	users=$(cat /etc/passwd | :grep  | cut -f 1 -d":")
	echo "user $i: $users";
done
