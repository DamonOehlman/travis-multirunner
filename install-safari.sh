#!/usr/bin/env bash

# Download and install Safari Tech Preview
if [ $BVER == "unstable" ] && [ ! -f "/Applications/Safari Technology Preview.app/Contents/MacOS/Safari Technology Preview" ]; then
  curl -L $1 > SDP.dmg
  hdiutil attach SDP.dmg
  sudo installer -pkg /Volumes/Safari\ Technology\ Preview/Safari\ Technology\ Preview.pkg -target /
fi

# If we're running on Travis
if [ ! -z $TRAVIS ]; then
  # Download and install Soundflower to get audio output devices otherwise we get crashes
  # https://bugs.webkit.org/show_bug.cgi?id=172794
  curl -L https://github.com/mattingalls/Soundflower/releases/download/2.0b2/Soundflower-2.0b2.dmg > Soundflower.dmg
  hdiutil attach Soundflower.dmg
  sudo installer -pkg /Volumes/Soundflower-2.0b2/Soundflower.pkg -target /
fi
