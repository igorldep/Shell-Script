#!/bin/bash

#Igor Luciano de Paula e Igor Lacerda

#Erro
function fatal() {
  echo "error: $@";
  exit 1;
}

#
function get_log() {
  local x=$1;
  local b=$2;

  printf "%.*f\n" 2 $(echo "l(${x})/l(${b}) + 0.99" | bc -l | tr "." ",") | sed "s/^\([[:digit:]]*\),.*$/\1/";
}


function check_teams() {
  printf '%.*f' 5 $(echo "l(${1})/l(2)" | bc -l | tr "." ",") | grep -E "^-?[[:digit:]]+,0+$" &>/dev/null
}

function next_random() {
  local bound=$1;
  expr "$(LC_ALL=C tr -cd '[:digit:]' < /dev/urandom | fold -w $(get_log "${bound}" 10) | sed "s/^0*\([[:digit:]]\)/\1/" | head -n 1)" % "${bound}";
}

function set_team_on_group_at() {
  local id=$1;
  local idx=$2;
  local team=$3;

  eval G${id}[$idx]=\"${team}\";
}

function get_team_on_group_at() {
  local id=$1;
  local idx=$2;

  eval "echo \"\${G${id}[$idx]}\"";
}

if [ $# -ne 2 ]; then
  echo "Usage: $0 [teams file] [# of teams per group]";
  exit 1;
fi

file=$1;
OLDIFS="${IFS}";
IFS=$'\n'
teams=($(cat "${file}"))
IFS="${OLDIFS}";

declare -i groups;
declare -i pergroup;
pergroup=$2;

[ ${pergroup} -gt 0 ] || fatal "Invalid number of teams per group";

groups=$((${#teams[@]} / ${pergroup}));
[ ${#teams[@]} -eq $((groups * pergroup)) ] || fatal "Invalid number of teams";

# Check the number of teams classified (two) for all groups.
check_teams $((groups * 2)) || fatal "Number of teams does not match logarithm of 2";

# Continue here...

num=${#teams[@]}

for((i=1; i < num*2 ; i++));do
	posicao1=$(next_random $num)
	posicao2=$(next_random $num)
	aux=${teams[$posicao]}
	teams[$posicao]=${teams[$posicao2]}
	teams[$posicao2]=$aux
done


k=0
for((i=0; i < groups ; i++));do
	for((j=0; j < pergroup ; j++));do
		set_team_on_group_at $i $j ${teams[k]}
		k=$((k+1))
	done
done

echo "Phase with groups"
for((i=0; i < groups ; i++));do
	echo "	Group $(($i+1)):"
	for((j=0; j < pergroup ; j++));do
		echo "		$(($j+1)): $(get_team_on_group_at $i $j)" 
		
	done
done

echo " "
echo "Phase with $(($groups*2)) teams"

echo "	Side A"

ganhador=0
for((i=0; i < groups ; i=i+2));do
	
	adv0=$(get_team_on_group_at $i 0)
	adv1=$(get_team_on_group_at $(($i+1)) 1)
	
	valor=$((RANDOM%2))
	if [ $valor -eq 0 ]; then
		echo "		$adv0 vs $adv1 [winner: $adv0]"
		proxfase[$ganhador]=$adv0
	else
		echo "		$adv0 vs $adv1 [winner: $adv1]"
		proxfase[$ganhador]=$adv1
	fi
	ganhador=$(($ganhador+1))
done


echo "	Side B"
for((i=0; i < groups ; i=i+2));do
	
	adv0=$(get_team_on_group_at $i 1)
	adv1=$(get_team_on_group_at $(($i+1)) 0)
	
	valor=$((RANDOM%2))
	if [ $valor -eq 0 ]; then
		echo "		$adv0 vs $adv1 [winner: $adv0]"
		proxfase[$ganhador]=$adv0
	else
		echo "		$adv0 vs $adv1 [winner: $adv1]"
		proxfase[$ganhador]=$adv1
	fi
	ganhador=$(($ganhador+1))
done

echo " "
grupo=$groups
ganhador=0

while [ $grupo -ge 4 ]; do
	echo "Phase with $grupo teams"
	echo "	Side A"

	for((i=0; i < grupo/2 ; i=i+2)); do
	
			valor=$((RANDOM%2))
			if [ $valor -eq 0 ]; then
					A=${proxfase[$i]}
					B=${proxfase[$(($i+1))]}	
					echo "		${proxfase[$i]} vs ${proxfase[$(($i+1))]} [winner: ${proxfase[$i]}]"
					proxfase[$ganhador]=$A
					if [ $grupo == 4 ]; then
						final[0]=$A
						terceiro[0]=$B
					fi
			else
					A=${proxfase[$i]}
					B=${proxfase[$(($i+1))]}
					echo "		${proxfase[$i]} vs ${proxfase[$(($i+1))]} [winner: ${proxfase[$(($i+1))]}]"
					proxfase[$ganhador]=$B
					if [ $grupo == 4 ]; then
						final[0]=$B
						terceiro[0]=$A
					fi
			fi
			ganhador=$(($ganhador+1))

	done
	
	echo "	Side B"

	for((i=grupo/2; i < grupo ; i=i+2)); do
	
			valor=$((RANDOM%2))
			if [ $valor -eq 0 ]; then
					
					echo "		${proxfase[$i]} vs ${proxfase[$(($i+1))]} [winner: ${proxfase[$i]}]"
					proxfase[$ganhador]=${proxfase[$i]}
					if [ $grupo == 4 ]; then
						final[1]=${proxfase[$i]}
						terceiro[1]=${proxfase[$(($i+1))]}
					fi
			else
					echo "		${proxfase[$i]} vs ${proxfase[$(($i+1))]} [winner: ${proxfase[$(($i+1))]}]"
					proxfase[$ganhador]=${proxfase[$(($i+1))]}
					if [ $grupo == 4 ]; then
						final[1]=${proxfase[$(($i+1))]}	
						terceiro[1]=${proxfase[$i]}
					fi
			fi
			ganhador=$(($ganhador+1))
	done
	echo " " #formatação
	ganhador=0
	grupo=$(($grupo/2))
done

echo "Results:"
#echo "final: ${final[@]}   terceiro: ${terceiro[@]}"

valor=$((RANDOM%2))
if [ $valor -eq 0 ]; then
	echo "	Champion: ${final[0]}"
	echo "	2nd: ${final[1]}"
else
	echo "	Champion: ${final[1]}"
	echo "	2nd: ${final[0]}"	
fi

valor2=$((RANDOM%2))
if [ $valor2 -eq 0 ]; then
	echo "	3rd: ${terceiro[0]}"
else
	echo "	3rd: ${terceiro[1]}"	
fi
