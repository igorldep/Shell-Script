#! /bin/bash

trap '' 1 2 3 18

a=$(($RANDOM%999+1))
b=$(($RANDOM%999+1))
signal=$(($RANDOM%2+1))

if [ "$signal" -eq 1 ]; then
	op='+'
else
	op='-'
fi

printf "  %5d\n  %c %3d\n  -----\n" $a $op $b
result=$(expr $a $op $b)

printf "? "
read res

if [ "$res" -ne "$result" ]; then
	until [ "$res" -eq "$result"  ]; do
		printf "Wrong answer\n? "
		read res
	done
fi

printf "Right answer\n"
