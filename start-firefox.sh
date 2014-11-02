#!/usr/bin/env bash
FIREFOX_COMMAND=${FIREFOX_COMMAND-firefox}
FIREFOX_HOME=$HOME/.mozilla/firefox

# determine the script path
# ref: http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

# set the prefs location
PREFS=$SCRIPTPATH/firefox-prefs.js

if [ -f $PREFS ]; then
  rm -rf $FIREFOX_HOME/*.integrationtest
  $FIREFOX_COMMAND --no-remote -CreateProfile integrationtest
  cp $SCRIPTPATH/firefox-prefs.js $FIREFOX_HOME/*.integrationtest/prefs.js
fi
# printf "{\n\"created\": $(date +%s%N | cut -b1-13)\n}" > $PROFILE_DIR/times.json

$FIREFOX_COMMAND --no-remote -P integrationtest $@
