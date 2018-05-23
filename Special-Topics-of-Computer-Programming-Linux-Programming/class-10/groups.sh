#! /bin/bash

echo "Groups: "

for gid in $(id -G); do
	group=$(cat /etc/group | grep ":$grid:" | cut -f 1 -d":")
	echo "   $group";
done
