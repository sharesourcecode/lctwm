_loginlogoff () {
# /login/logoff
	COOKIE=$HOME/lctwm/.cookie
	ACC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/user" | sed 's/src=/\n/g' | grep '/images/icon/race/' | cut -d\> -f2 | cut -d\< -f1) # | grep [[:alpha:]])
	[[ -n $ACC ]] && i=5 && \
          until [[ $i -lt 1 ]]; do
		clear
		echo -e "[Wait to $ACC... ("$i"s) - ENTER to other account] \n"
                i=$[$i-1]; read -t1 && \
		ACC="" && break
        done
	clear
	while [[ -z $ACC ]]; do
		function _login () {
# /logoff
			curl -b $COOKIE "$URL/?exit" -A "$(shuf -n1 .ua)" 2&>-
			unset login; unset pass
			echo -e "\nIn case of error will repeat"
			echo -n 'login: '
			read login
			echo -e "\n"
			prompt="pass: "
			charcount=0
			while IFS= read -p "$prompt" -r -s -n 1 char; do
# /Enter - accept password
			if [[ $char == $'\0' ]]; then
				break
			fi
# /Backspace
			if [[  $char  == $'\177' ]]; then
				if [ $charcount -gt 0 ]; then
					charcount=$((charcount - 1))
					prompt=$'\b \b'
					pass="${pass%?}"
				else
					prompt=''
				fi
			else
				charcount=$((charcount + 1))
				prompt='🔒'
				pass+="$char"
			fi
			done
			echo -e "\n	Please wait..."
# /create log
			LOGIN=`echo "$login" | tr '[:upper:]' '[:lower:]' | sed "s, ,~,g"`

			rm $HOME/lctwm/*.l &> /dev/null
			for i in `echo "/:^$LOGIN^$pass^^✓"|fold -w1`
			do
				echo 'key '$i >> w.l
			done
			sed "s/key ~/key <space>/g" w.l >y.l && \
			sed "s/key ^/key ^J/g" y.l >k.l
			sed "s/key ✓/key ^C/g" k.l >.lsign
pwd
# /cookie save
#			rm $COOKIE &> /dev/null
			lynx -cfg=$HOME/lctwm/cfg1 -cmd_script=$HOME/lctwm/.lsign "$URL/?sign_in=1" -useragent="$(shuf -n1 .ua)"
			unset login; unset pass
			rm $HOME/lctwm/*.l &> /dev/null
		}
		_login
#		clear
		ACC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/user" | sed 's/src=/\n/g' | grep '/images/icon/race/' | cut -d\> -f2 | cut -d\< -f1) #| grep [[:alpha:]])
	done
	echo "$ACC"
}
