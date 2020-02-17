# /clandungeon
function _clandungeon () {
	_clanid
	COOKIE=$HOME/lctwm/.cookie
	if [[ -n $CLD ]]; then
		echo "Checking Clan Dungeon..."
		SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/clandungeon/?close")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/clandungeon/attack/' | head -n1 | cut -d\' -f2)
		EXIST=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'clandungeon/attack')
		until [[ -z $EXIST ]]; do
			SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL$ACCESS")
			ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/clandungeon/attack/' | head -n1 | cut -d\' -f2)
			EXIST=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'clandungeon/attack')
			echo " ⚔ $ACCESS"
		done
		echo -e "Clan Dungeon (✔)\n"
	fi
}
