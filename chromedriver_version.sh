#!/usr/bin/env bash
set -x
set -e

BINPATH=./browsers/bin
VERSION=`$BINPATH/chrome-$BVER --version | awk '{print $3}'`
MAJOR=`$BINPATH/chrome-$BVER --version | awk '{print $3}' | awk -F '.' '{print $1}'`

# http://chromedriver.chromium.org/downloads/version-selection
CHROMEDRIVER_VERSION=$(curl -f https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${VERSION} \
 || curl -f https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${MAJOR} \
 || curl -f https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$((MAJOR - 1)))

echo $CHROMEDRIVER_VERSION
