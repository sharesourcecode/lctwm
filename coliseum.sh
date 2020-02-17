_coliseum () {
	COOKIE=$HOME/lctwm/.cookie
# /enterFight
	SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" $URL/settings/graphics/1)
	HPER='49'
	RPER='9'
	ITVL='1.8'
	echo -e "\nColiseum"
	echo $URL
	curl -b $COOKIE -A "$(shuf -n1 .ua)" $URL/coliseum/?end_fight=true | head -n11 | tail -n7 | sed "/\[2hit/d;/\[str/d;/combat/d"
	SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" $URL/coliseum)
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/enterFight/' | head -n1 | cut -d\' -f2)
	echo -e " 👣 Entering...\n$ACCESS"
	SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" ""$URL$ACCESS"?end_fight=true")
# /wait
	echo " 😴 Waiting..."
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/coliseum/' | head -n1 | cut -d\' -f2)
        EXIT=$(echo $SRC | grep -o '/leaveFight/' | head -n1)
	START=`date +%M`
	while [[ -n $EXIT ]] ; do
                END=$(expr `date +%M` \- $START)
                [[ $END -gt 7 ]] && break
		echo -e " 💤	...\n$ACCESS"
		SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" $URL/coliseum)
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/coliseum/' | head -n1 | cut -d\' -f2)
		EXIT=$(echo $SRC | grep -o '/leaveFight/' | head -n1)
	done
	FULL=$(echo $SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd '[[:digit:]]')
	_access
	HP3=$HP1
	until [[ -n $BEXIT && -z $OUTGATE ]] ; do
# /dodge
		[[ $HP3 -ne $HP1 ]] && echo '🛡️' && \
		SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL$DODGE") && \
		HP3=$HP1 && _access
# /atk
		echo '🎯' && \
		SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL$ATK")
		_access
# /heal
		[[ $HP1 -le $HLHP ]] && ITVL='2.6' && echo "🆘 HP < $HPER%" && \
		SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL$HEAL") && \
		_access
# /random
		[[ $WDRED == white && `expr $HP1 + $HP1 \* $RPER \/ 100` -le $HP2 ]] && echo '🔁' && \
		SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL$ATKRND") && \
		_access
		sleep $ITVL
	done
# /view
	echo ""
	curl -b $COOKIE -A "$(shuf -n1 .ua)" $URL/coliseum | head -n15 | tail -n14 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d"
	echo "Coliseum (✔)"
	SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" $URL/settings/graphics/0)
}
