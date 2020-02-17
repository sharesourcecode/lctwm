# /clan id
_clanid () {
	SRC=$(curl -b $HOME/lctwm/.cookie -A "$(shuf -n1 .ua)" "$URL/clan")
	CLD=$(echo $SRC | sed "s/\/clan\//\\n/g" | grep 'built\/' | cut -d\/ -f1)
	echo "Clan ID: $CLD"
}
