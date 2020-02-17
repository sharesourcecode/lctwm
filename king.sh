_king () {
	COOKIE=$HOME/lctwm/.cookie
# /enterFight
	SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" $URL/settings/graphics/1)
	HPER='49'
	RPER='1'
	ITVL='1.8'
	echo -e "\nKing"
	echo $URL
	SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" $URL/king/enterGame)
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/king/' | head -n1 | cut -d\' -f2)
	echo -e " 👣 Entering...\n$ACCESS"
# /wait
	echo " 😴 Waiting..."
        EXIT=$(echo $SRC | grep -o 'king/kingatk/')
	START=`date +%M`
	while [[ -z $EXIT ]] ; do
		END=$(expr `date +%M` \- $START)
		[[ $END -gt 6 ]] && break
		echo -e " 💤	...\n$ACCESS"
		SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL$ACCESS")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/king/' | head -n1 | cut -d\' -f2)
		EXIT=$(echo $SRC | grep -o 'king/kingatk/')
	done
# /game
	FULL=$(echo $SRC | sed "s/alt/\\n/g" | grep "hp" | head -n1 | cut -d\< -f2 | cut -d\> -f2 | tr -cd "[[:digit:]]")
	_access
	HP3=$HP1
	START=`date +%M`
	until [[ -n $BEXIT && -z $OUTGATE ]] ; do
		END=$(expr `date +%M` \- $START)
		[[ $END -gt 11 ]] && break
# /dodge
		[[ $HP3 -ne $HP1 ]] && HP3=$HP1 && echo '🛡️' && \
		SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL$DODGE") && \
		_access
# /kingatk
		[[ -n $KINGATK ]] && echo '👑' && \
		SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL$KINGATK") && \
		_access
# /attack
		[[ -z $KINGATK ]] && echo '🎯' && \
		SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL$ATTACK")
		_access
# /heal
		[[ $HP1 -le $HLHP ]] && ITVL='2.6' && echo "🆘 HP < $HPER%" && \
		SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL$HEAL") && \
		_access
# /grass
		[[ `expr $HP1 + $HP1 \* 1 \/ 100` -le $HP2 || `expr $HP1 + $HP1 \* 1 \/ 100` -le $HP3 ]] && echo '🙌' && \
		SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL$GRASS") && \
		_access
# /stone
		[[ `expr $HP1 + $HP1 \* 1 \/ 100` -le $HP2 || $HP2 -le 15 ]] && echo '💪' && \
		SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL$STONE") && \
		_access
# /random
		[[ $WDRED == white && `expr $HP1 + $HP1 \* $RPER \/ 100` -le $HP2 ]] && echo '🔁' && \
		SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL$ATTACKRANDOM") && \
		_access
		sleep $ITVL
	done
# /view
	echo ""
	curl -b $COOKIE -A "$(shuf -n1 .ua)" $URL/king | head -n15 | tail -n14 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d"
	echo "King (✔)"
	SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" $URL/settings/graphics/0)
	sleep 30
	_coliseum
}
