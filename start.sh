# !/usr/bin/env bash
PARAMS=$@
launch() {
	LAUNCHCMD="start-$1"
	hash "$LAUNCHCMD" &> /dev/null
	if [ $? -eq 1 ]; then
		LAUNCHCMD="./start-$1.sh"
	fi
	. $LAUNCHCMD $PARAMS
}

if [ -z $BROWSER ]; then
	echo "No BROWSER variable specified, defaulting to locally installed Chrome"
	# Default to Chrome
	case $OSTYPE in
		darwin*) LOCATION="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome";;
		linux*) ;;
	esac
	launch chrome
else
	launch $BROWSER
fi