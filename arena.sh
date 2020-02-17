# /arena
function _arena () {
	_clanid
	COOKIE=$HOME/lctwm/.cookie
	if [[ -n $CLD ]]; then
		curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/clan/$CLD/quest/take/3" &
		curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/clan/$CLD/quest/help/3" &
		curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/clan/$CLD/quest/take/4" &
		curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/clan/$CLD/quest/help/4" &
	fi
	SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/arena/")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'arena/attack' | head -n1 | cut -d\' -f2) #/arena/attack/1/1234567*/
	EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep 'lab/wizard' | head -n1 | cut -d\' -f2) #/lab/wizard/potion/1234567*/?ref=/arena/
	while [[ -z $EXIT && -n $ACCESS ]]; do
		SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL$ACCESS")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'arena/attack' | head -n1 | cut -d\' -f2) #/arena/attack/1/1234567*/
		echo "$ACCESS"
		EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep 'lab/wizard' | head -n1 | cut -d\' -f2) #/lab/wizard/potion/1234567*/?ref=/arena/
	done
	if [[ -n $CLD ]]; then
		curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/clan/$CLD/quest/end/3" &
		curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/clan/$CLD/quest/deleteHelp/3" &
		curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/clan/$CLD/quest/end/4" &
		curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/clan/$CLD/quest/deleteHelp/4" &
	fi
	echo -e "arena (✔)\n"
}
