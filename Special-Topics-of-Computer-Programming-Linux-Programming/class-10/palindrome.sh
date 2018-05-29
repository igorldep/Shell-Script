#! /bin/bash

while read line
do

	newline=$(echo $line | tr 'A-Z' 'a-z' | sed "s/[^a-z]//g")
	#echo $newline
	revline=$(echo $line | tr 'A-Z' 'a-z' | rev | sed "s/[^a-z]//g")
	#echo $revline
	if [ "$newline" == "$revline" ]; then
		echo "Yes"
	else
		echo "No"
	fi
done
