_undying () {
	COOKIE=$HOME/lctwm/.cookie
# /enterGame
	echo "Undying"
	curl -b $COOKIE -A "$(shuf -n1 .ua)" $URL/undying/enterGame | head -n5
#
	echo " 👣 Entering..."
	SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" $URL/undying)
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/undying/' | head -n1 | cut -d\' -f2)
	_access
# /wait
	echo " 😴 Waiting..."
	START=`date +%M`
	until [[ -n $MANA ]] ; do
		END=$(expr `date +%M` \- $START)
		[[ $END -gt 6 ]] && break
		echo -e " 💤 	..."
		SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL$ACCESS")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/undying/' | head -n1 | cut -d\' -f2)
		_access
	done
	SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL$ACCESS")
	_access
	while [[ -n $OUTGATE ]] ; do
		END=`date +%M`
		[[ $END = 05 ]] && break
		echo -e " 🎲 hiting..."
		SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL$HIT")
		_access
		sleep 1.5
	done
# /view
	echo ""
	curl -b $COOKIE -A "$(shuf -n1 .ua)" $URL/undying | head -n15 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color "$ACC"
	echo -e "Undying (✔)"
	SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" $URL/settings/graphics/0)
	sleep 30
	_coliseum
}
