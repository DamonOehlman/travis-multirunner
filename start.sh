# !/usr/bin/env bash
echo "Starting Travis CI multiple browser runner"
echo "-----------"
echo "Parameters:"
echo "$@"
echo "-----------"

if [ -z $BROWSER ]; then
	echo "No BROWSER variable specified, defaulting to locally installed Chrome"
	# Default to Chrome
	case $OSTYPE in
		darwin*) LOCATION="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome";;
		linux*) ;;
	esac
	TARGET="chrome"
else
	TARGET=$BROWSER
fi

# Execute the appropriate script
LAUNCHCMD="start-$TARGET"
# Check if the launch command is accessible
hash "$LAUNCHCMD" 2>/dev/null
if [ $? -eq 1 ]; then
	LAUNCHCMD="./start-$TARGET.sh"
fi
# Exit if we can't find the launch command
hash "$LAUNCHCMD" 2>/dev/null
if [ $? -eq 1 ]; then
	echo "Could not find launch command! [${LAUNCHCMD}]"
	exit 1;
fi

echo "Launching ${LAUNCHCMD}..."
. "$LAUNCHCMD" "$@"