#! /bin/bash

n=$1
um=0;
dois=0;
tres=0;
quatro=0;
cinco=0;
seis=0;

for i in $(seq 1 $n);do
	aux=$((($RANDOM%6)+1))
	
	case "$aux" in
		1)
			um=$(($um+1))
			;;
		2)
			dois=$(($dois+1))
			;;
		3)
			tres=$(($tres+1))
			;;
		4)
			quatro=$(($quatro+1))
			;;
		5)
			cinco=$(($cinco+1))
			;;
		6)
			seis=$(($seis+1))
			;;
	esac
done

	echo "Dice 1: $um"
	echo "Dice 2: $dois"
	echo "Dice 3: $tres"
	echo "Dice 4: $quatro"
	echo "Dice 5: $cinco"
	echo "Dice 6: $seis"
