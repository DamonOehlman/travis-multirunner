# !/usr/bin/env bash
if [ -z $BROWSER ]; then
	echo "No BROWSER variable specified, defaulting to locally installed Chrome"
	# Default to Chrome
	case $OSTYPE in
		darwin*) LOCATION="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome";;
		linux*) ;;
	esac
	. ./start-chrome.sh
else
	. ./start-$BROWSER.sh
fi