#! /bin/bash

FILE=$*
PERMISSAO=(- - -)

if [ -e "$FILE" ]; then #existe ?
	if [ -f "$FILE" ]; then #é um arquivo regular
		if [ -r "$FILE" ]; then
			PERMISSAO[0]=r
		fi
		if [ -w "$FILE" ]; then
                        PERMISSAO[1]=w
                fi
		if [ -x "$FILE" ]; then
                        PERMISSAO[2]=x
         	fi
		
		echo "$FILE: arquivo ($( echo ${PERMISSAO[@]} | sed -e 's/[^a-z]//ig'))"
	
	elif [ -d "$FILE" ]; then #é um diretório
		if [ -r "$FILE" ]; then
			PERMISSAO[0]=r
		fi
		if [ -w "$FILE" ]; then
                        PERMISSAO[1]=w
                fi
		if [ -x "$FILE" ]; then
                        PERMISSAO[2]=x
         	fi
		
		echo "$FILE: diretório ($( echo ${PERMISSAO[@]} | sed -e 's/[^a-z]//ig'))"
	

	 else
		if [ -r "$FILE" ]; then
			PERMISSAO[0]=r
		fi
		if [ -w "$FILE" ]; then
                        PERMISSAO[1]=w
                fi
		if [ -x "$FILE" ]; then
                        PERMISSAO[2]=x
         	fi
		
		echo "$FILE: desconhecido ($( echo ${PERMISSAO[@]} | sed -e 's/[^a-z]//ig'))"
	fi
	


elif [ "$FILE" == "" ]; then

	echo "Usar: ./checkfile [Arquivo]" 1>&2


else
	echo "$FILE: inválido"

fi
