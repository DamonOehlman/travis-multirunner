#!/usr/bin/env bash

# Download and install Safari Tech Preview
if [ $BVER == "unstable" ] && [ ! -f "/Applications/Safari Technology Preview.app/Contents/MacOS/Safari Technology Preview" ]; then
  curl -L $1 > SDP.dmg
  hdiutil attach SDP.dmg
  sudo installer -pkg /Volumes/Safari\ Technology\ Preview/Safari\ Technology\ Preview.pkg -target /
fi
# Safari stable is already installed, no need to do anything

# If we're running on Travis
if [ ! -z $TRAVIS ]; then
  # Download and install Soundflower to get audio output devices otherwise we get crashes
  # https://bugs.webkit.org/show_bug.cgi?id=172794
  curl -L https://github.com/mattingalls/Soundflower/releases/download/2.0b2/Soundflower-2.0b2.dmg > Soundflower.dmg
  hdiutil attach Soundflower.dmg
  sudo installer -pkg /Volumes/Soundflower-2.0b2/Soundflower.pkg -target /
fi

if [ $BVER == "unstable" ]; then
  SAFARI_NAME="Safari Technology Preview"
  SAFARI_SHORT_NAME="SafariTechnologyPreview"
else
  SAFARI_NAME="Safari"
  SAFARI_SHORT_NAME="Safari"
fi

# Tell Safari not to restore the browser windows when it is relaunched
defaults write com.apple.$SAFARI_SHORT_NAME ApplePersistenceIgnoreState YES

# Turn on fake devices
defaults write com.apple.$SAFARI_SHORT_NAME WebKitMockCaptureDevicesEnabled 1
defaults write com.apple.$SAFARI_SHORT_NAME com.apple.Safari.ContentPageGroupIdentifier.WebKit2MockCaptureDevicesEnabled 1

# Allow insecure domains
defaults write com.apple.$SAFARI_SHORT_NAME WebKitMediaCaptureRequiresSecureConnection 0

# Turn on Allow Remote Automation. This only works in Mac OS 10.13+
MAC_OS_VERSION=`defaults read loginwindow SystemVersionStampAsString`
if [[ $MAC_OS_VERSION =~ ^10\.1[3-9]\..+ ]]; then
  sudo safaridriver --enable
fi

# Allow device access
# This UserMediaPermissions.plist file allows 127.0.0.1 and localhost. To add other domains
# you need to run Safari Technology Preview on your system, visit the domain you want to allow
# and call navigator.mediaDevices.getUserMedia. When prompted allow access to devices allow access
# then click on the red camera in the URL bar and choose "Always Allow".
# Finally copy the `~/Library/SafariTechnologyPreview/UserMediaPermissions.plist` file into the
# same directory on Travis.
open -a "$SAFARI_NAME"
sleep 2
killall "$SAFARI_NAME"
cp ./UserMediaPermissions.plist ~/Library/$SAFARI_SHORT_NAME/
