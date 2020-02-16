# /clandungeon
function _clandungeon () {
	_clanid
	if [[ -n $CLD ]]; then
		echo "Checking Clan Dungeon..."
		SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/clandungeon/?close" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/clandungeon/attack/' | head -n1 | cut -d\' -f2)
		EXIST=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'clandungeon/attack')
		until [[ -z $EXIST ]]; do
			SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
			ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/clandungeon/attack/' | head -n1 | cut -d\' -f2)
			EXIST=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'clandungeon/attack')
			echo " ⚔ $ACCESS"
		done
		echo -e "Clan Dungeon (✔)\n"
	fi
}
