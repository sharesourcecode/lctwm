_play () {
	_all () {
		_arena
		_campaign
		_career
		_clandungeon
		_trade
#		_torstop
	}
_crono
# /game time
	if [[ $HOUR -lt 8 || $HOUR -eq 23 ]] ; then
		_all
#		_coliseum
		_sleep
		_crono
# /Valley of the Immortals 10:00:00 - 16:00:00 - 22:00:00
	elif [[ $HOUR -eq 9 && $MIN -ge 45 || $HOUR -eq 15 && $MIN -ge 45 || $HOUR -eq 21 && $MIN -ge 45 ]] ; then
		START=`date +%M`
		while [[ $MIN -ge 45 && $MIN -le 59 ]] ; do
        	        END=$(expr `date +%M` \- $START)
	                [[ $END -gt 15 ]] && break
			echo 'Valley of the Immortals will be started...'
			_sleep
			if [[ $MIN -ge 58 ]] ; then
				_undying
				break
			fi
		done
		_crono
# /Battle of banners 10:15:00 - 16:15:00
#	elif [[ $HOUR -eq 10 && $MIN -gt 10 && $MIN -lt 16 || $HOUR -eq 16 && $MIN -gt 10 && $MIN -lt 16 ]] ; then
#		ts=300
#		SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" $URL/flagfight/enterFight)
#		_crono
# /Clan coliseum 10:30:00 - 15:00:00
#	elif [[ -n $CLD && $HOUR -eq 10 && $MIN -ge 15 && $MIN -le 30 || -n $CLD && $HOUR -eq 14 && $MIN -ge 45 ]] ; then
#		START=`date +%M`
#		while [[ $MIN -ge 15 && $MIN -le 30 || $MIN -ge 45 && $MIN -le 59 ]] ; do
#	                END=$(expr `date +%M` \- $START)
#        	        [[ $END -gt 16 ]] && break
#			echo 'Clan coliseum will be started...'
#			sleep 30
#			_crono
#			if [[ $MIN -ge 29 || $MIN -ge 59 ]] ; then
#				SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/clancoliseum/?close=reward")
#				SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/clancoliseum/enterFight")
#				_clancoliseum
#				break
#			fi
#		done
#		_crono
# /Clan tournament 11:00:00 - 19:00:00
	elif [[ -n $CLD && $HOUR -eq 10 && $MIN -ge 45 || -n $CLD && $HOUR -eq 18 && $MIN -ge 45 ]] ; then
		START=`date +%M`
		while [[ $MIN -ge 45 && $MIN -le 59 ]] ; do
        	        END=$(expr `date +%M` \- $START)
	                [[ $END -gt 16 ]] && break
			echo 'Clan tournament will be started...'
			sleep 30
			_crono
			if [[ $MIN -ge 55 ]] ; then
				SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/clanfight/enterFight/?close_clan_msg=true")
				_clanfight
				break
			fi
		done
		_crono
# /King of the Immortals 12:30:00 - 16:30:00 - 22:30:00
	elif [[ $HOUR -eq 12 && $MIN -ge 15 && $MIN -le 30 || $HOUR -eq 16 && $MIN -ge 15 && $MIN -le 30 || $HOUR -eq 22 && $MIN -ge 15 && $MIN -le 30 ]] ; then
		START=`date +%M`
		while [[ $MIN -ge 15 && $MIN -le 30 ]] ; do
        	        END=$(expr `date +%M` \- $START)
	                [[ $END -gt 15 ]] && break
			echo 'King of the Immortals will be started...'
			_sleep
			if [[ $MIN -ge 28 && $MIN -le 30 ]] ; then
				_king
				break
			fi
		done
		_crono
# /Ancient Altars 14:00:00 - 21:00:00
	elif [[ -n $CLD && $HOUR -eq 13 && $MIN -ge 45 || -n $CLD && $HOUR -eq 20 && $MIN -ge 45 ]] ; then
		START=`date +%M`
		while [[ $MIN -ge 45 && $MIN -le 55 ]] ; do
        	        END=$(expr `date +%M` \- $START)
	                [[ $END -gt 15 ]] && break
			echo 'Ancient Altars will be started...'
			sleep 30
			_crono
		done
		if [[ $MIN -ge 55 ]] ; then
			SRC=$(curl -b $COOKIE -A "$(shuf -n1 .ua)" "$URL/altars/enterFight/?close_clan_msg=true")
			_altars
			break
		fi
		_crono
	else
		_all
		_sleep
		_crono
	fi
}
