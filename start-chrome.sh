# !/usr/bin/env bash
BVER=${BVER-stable}
DEBUG_OPTS="--enable-logging --v=1 --vmodule=*third_party/libjingle/*=3,*=0"
EXTRA_OPTS="--no-sandbox --disable-setuid-sandbox --allow-sandbox-debugging"
UUID=$(cat /proc/sys/kernel/random/uuid)
BROWSER_COMMAND=./browsers/bin/chrome-$BVER
SCRIPTPATH=$(dirname "$(readlink -f $0)")

#  --log-level=3 \
#  --use-fake-device-for-media-stream \
#  --use-fake-ui-for-media-stream \

if [ ! -e $BROWSER_COMMAND ]; then
  echo "could not find chrome executable: $BROWSER_COMMAND\n";
  exit 1;
fi

$BROWSER_COMMAND --disable-setuid-sandbox \
  --console \
  --user-data-dir=$SCRIPTPATH/profiles/$(UUID)/ \
  --no-first-run $@
