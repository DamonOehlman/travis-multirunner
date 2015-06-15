#!/usr/bin/env bash
BVER=${BVER-stable}
FIREFOX_COMMAND=./browsers/bin/firefox-$BVER
FIREFOX_HOME=$HOME/.mozilla/firefox

# determine the script path
# ref: http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
SCRIPTPATH=$(dirname "$(readlink -f $0)")

# set the prefs location
PREFS=$SCRIPTPATH/firefox-prefs.js

if [ ! -e $FIREFOX_COMMAND ]; then
  echo -en "could not find firefox executable: $FIREFOX_COMMAND\n";
  exit 1;
fi

if [ -f $PREFS ]; then
  rm -rf $FIREFOX_HOME/*.integrationtest
  $FIREFOX_COMMAND --no-remote -CreateProfile integrationtest
  cp $SCRIPTPATH/firefox-prefs.js $FIREFOX_HOME/*.integrationtest/prefs.js
fi
# printf "{\n\"created\": $(date +%s%N | cut -b1-13)\n}" > $PROFILE_DIR/times.json

$FIREFOX_COMMAND --no-remote -P integrationtest $@
