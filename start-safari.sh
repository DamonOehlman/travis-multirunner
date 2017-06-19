if [ $BVER == "unstable" ]; then
  SAFARI_NAME="Safari Technology Preview"
else
  SAFARI_NAME="Safari"
fi

# Delete Safari Session State Key, otherwise you get a system message to allow access
sudo security delete-generic-password -l "Safari Session State Key"

# Tell Safari not to restore the browser windows when it is relaunched
defaults write com.apple.safari ApplePersistenceIgnoreState YES

# Turn on fake devices
defaults write com.apple.Safari WebKitMockCaptureDevicesEnabled 1
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2MockCaptureDevicesEnabled 1

# Allow device access
# This UserMediaPermissions.plist file allows 127.0.0.1 and localhost. To add other domains
# you need to run Safari Technology Preview on your system, visit the domain you want to allow
# and call navigator.mediaDevices.getUserMedia. When prompted allow access to devices allow access
# then click on the red camera in the URL bar and choose "Always Allow".
# Finally copy the `~/Library/SafariTechnologyPreview/UserMediaPermissions.plist` file into the
# same directory on Travis.
open -a "$SAFARI_NAME"
sleep 1
killall "$SAFARI_NAME"
cp ./UserMediaPermissions.plist ~/Library/SafariTechnologyPreview/

open -a "$SAFARI_NAME" $@
