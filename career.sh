# /career
# /career/attack/?r=8781779
_career () {
	echo "Checking career..."
	_clanid
	COOKIE=$HOME/lctwm/.cookie
	if [[ -n $CLD ]]; then
		echo "Clan ID: $CLD"
		curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/clan/$CLD/quest/take/6" &
		curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/clan/$CLD/quest/help/6" &
	fi
	SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/career")
	ENTER=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'career/attack')
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/career/attack/' | head -n1 | cut -d\' -f2)
	until [[ -z $ENTER ]]; do
		SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL$ACCESS")
		ENTER=$(echo $SRC | sed 's/href=/\n/g' | grep -o 'career/attack')
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep '/career/attack/' | head -n1 | cut -d\' -f2)
		echo " ⚔ $ACCESS"
	done
	if [[ -n $CLD ]]; then
		curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/clan/$CLD/quest/deleteHelp/6" &
		curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/clan/$CLD/quest/end/6"
	fi
	echo -e "career (✔)\n"
}
