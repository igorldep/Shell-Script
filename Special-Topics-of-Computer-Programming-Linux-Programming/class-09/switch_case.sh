#!/bin/bash

echo -n "Enter A, B, or C: "
read letter

case "$letter" in
	a|A)
		echo "You entered A"
		;;

	b|B)
		echo "You entered B"
		;;

	c|C)
		echo "You entered C"
		;;

	*)
		echo "You did not enter A, B or C"
		;;

esac
