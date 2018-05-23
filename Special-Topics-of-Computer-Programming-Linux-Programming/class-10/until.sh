#! /bin/bash

secname=zach
name=

echo "Try to guess the secret name!"
echo

until [ "$name" = "$secname" ]; do
	echo -n "Your Guess: "
	read name
done

echo "Very good"
