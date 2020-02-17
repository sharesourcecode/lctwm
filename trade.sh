# /trade
function _trade () {
	COOKIE=$HOME/lctwm/.cookie
	echo "Checking for gold exchange..."
	SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/trade/exchange")
	ACCESS=$(echo $SRC | sed "s/\/trade/\\n/g" | grep 'exchange'| grep 'silver/1' | head -n1 | cut -d\= -f2 | cut -d\' -f1)
	EXIST=$(echo $SRC | sed "s/\/trade/\\n/g" | grep 'exchange' | grep 'silver/1' | head -n1 | cut -d\/ -f3)
	while [[ -n $EXIST ]]; do
		SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/trade/exchange/silver/1?r=$ACCESS")
		ACCESS=$(echo $SRC | sed "s/\/trade/\\n/g" | grep 'exchange'| grep 'silver/1' | head -n1 | cut -d\= -f2 | cut -d\' -f1)
		EXIST=$(echo $SRC | sed "s/\/trade/\\n/g" | grep 'exchange' | grep 'silver/1' | head -n1 | cut -d\/ -f3)
		echo "$ACCESS"
	done
	echo -e "Exchange (✔)\n"
}
