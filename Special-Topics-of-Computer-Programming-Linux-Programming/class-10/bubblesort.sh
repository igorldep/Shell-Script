#! /bin/bash

#	BubbleSort

n=0

for arg; do
       	input[n]=$arg
	n=$((n+1))  
done

echo ${input[*]} #tira
 
for (( i = 0; i < $n ; i++ )) do
	for (( j = $i; j < $n; j++ )) do
		if [ ${input[$i]} -gt ${input[$j]}  ]; then
			aux=${input[$i]}
			input[$i]=${input[$j]}
			input[$j]=$aux
		fi
	done
done

echo ${input[*]} #tira



