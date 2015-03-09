#!/usr/bin/env bash

# firefox base details
MOZILLA_BUILDS=http://ftp.mozilla.org/pub/mozilla.org/firefox
NIGHTLY_VERSION="39.0a1"

function firefoxRelease {
  echo $MOZILLA_BUILDS/releases/$1/linux-x86_64/en-US/firefox-$1.tar.bz2
}

# initialise the firefox versions
declare -A FIREFOX_VERSIONS
FIREFOX_VERSIONS[stable]=$(firefoxRelease 36.0)
FIREFOX_VERSIONS[beta]=$(firefoxRelease 37.0b3)
FIREFOX_VERSIONS[nightly]=$MOZILLA_BUILDS/nightly/latest-trunk/firefox-$NIGHTLY_VERSION.en-US.linux-x86_64.tar.bz2

export FIREFOX_VERSIONS
