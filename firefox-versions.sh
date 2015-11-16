#!/usr/bin/env bash

# firefox base details

MOZILLA_BUILDS=https://archive.mozilla.org/pub/firefox
NIGHTLY_VERSION="45.0a1"


function firefoxRelease {
  echo https://download.mozilla.org/?product=firefox-$1&os=linux64&lang=en-US
}

# initialise the firefox versions
declare -A FIREFOX_VERSIONS
FIREFOX_VERSIONS[stable]=$(firefoxRelease latest)
FIREFOX_VERSIONS[beta]=$(firefoxRelease latest-beta)
FIREFOX_VERSIONS[nightly]=$MOZILLA_BUILDS/nightly/latest-mozilla-central/firefox-$NIGHTLY_VERSION.en-US.linux-x86_64.tar.bz2

export FIREFOX_VERSIONS
