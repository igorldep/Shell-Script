BEGIN {
        FS = ":"
	i   = 0; min = 0; max = 0; sum = 0;
#	num = $(cat ./compaign.data | wc -l)
	printf"Nome			Telefone	  Jan	    Fev	    Mar	    Total\n"
	printf"-------------------------------------------------------------------------------\n"
		
}
#
i  < 1   {min = $3; max = $3}
$3 < min {min = $3}
$4 < min {min = $4}
$5 < min {min = $5}
$3 > max {max = $3}
$4 > max {max = $4}
$5 > max {max = $5}

#
    {i+=1; sum+=$3+$4+$5; printf "%-16s	%-7s 	%7d	%7.2f	%7.2f	%7.2f\n", $1, $2, $3, $4, $5, $3+$4+$5 }
#    {i+=1; sum+=$3+$4+$5; print $1"			"$2"	"$3".00""	"$4".00""	"$5".00""	"$3+$4+$5".00"}  
END{
	printf"\nRelatório\n"
	printf"-------------------------------------------------------------------------------\n"
	printf"Total recebido: %.2f\n", sum
	printf"Contribuição Média: %.2f\n", (sum/i)
	printf"Menor Contribuição: %.2f\n", min
	printf"Maior Contribuição: %.2f\n", max
}
