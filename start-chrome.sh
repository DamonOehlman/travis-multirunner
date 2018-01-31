# !/usr/bin/env bash
BVER=${BVER-stable}
DEBUG_OPTS="--enable-logging --v=1 --vmodule=*third_party/libjingle/*=3,*=0"
EXTRA_OPTS="--no-sandbox --disable-setuid-sandbox --allow-sandbox-debugging"
case $OSTYPE in
	darwin*)
		UUID=$(/usr/bin/uuidgen)
		SCRIPTPATH=$(dirname "$(readlink -f $0)")
	;;
	*)
		echo "Generating UUID for profile..."
		UUID=$(cat /proc/sys/kernel/random/uuid)
		SCRIPTPATH=$(dirname "$(readlink -f $0)")
	;;
esac
BROWSER_COMMAND=${LOCATION:=./browsers/bin/chrome-$BVER}
#  --log-level=3 \
#  --use-fake-device-for-media-stream \
#  --use-fake-ui-for-media-stream \
if [ ! -e "$BROWSER_COMMAND" ]; then
  echo "could not find chrome executable: $BROWSER_COMMAND\n";
  exit 1;
fi

echo "Opening $@ in $BROWSER_COMMAND"
"$BROWSER_COMMAND" --disable-setuid-sandbox \
  --console \
  --user-data-dir=$SCRIPTPATH/profiles/$UUID/ \
  --use-fake-device-for-media-stream \
  --use-fake-ui-for-media-stream \
  --allow-file-access-from-files \
  --no-default-browser-check \
  --no-sandbox \
  --no-first-run "$@"
