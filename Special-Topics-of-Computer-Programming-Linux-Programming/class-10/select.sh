#! /bin/bash

PS3="ecolha uma opção: "

select fruit in apple banana blueberry kiwi orange watermelon STOP; do

if [ $REPLY -eq 7 ]; then
	break;
fi

done
