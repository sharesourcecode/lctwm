# /campaign
_campaign () {
	COOKIE=$HOME/lctwm/.cookie
	SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/campaign")
	ENTER=$(echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | cut -d\' -f1 | cut -d\/ -f3)
	ACCESS=$(echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | cut -d\' -f1)
	while [[ -n $ENTER && -n $ACCESS ]]; do
		SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" $URL$ACCESS)
		ENTER=$(echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | cut -d\' -f1 | cut -d\/ -f3)
		ACCESS=$(echo $SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | cut -d\' -f1)
		echo "$ACCESS"
	done
}
