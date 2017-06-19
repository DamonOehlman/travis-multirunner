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
cp ./UserMediaPermissions.plist ~/Library/SafariTechnologyPreview/

open -a "$SAFARI_NAME" $@
