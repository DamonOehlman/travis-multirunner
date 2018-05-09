#!/usr/bin/env bash
set -x
set -e

if [ $BROWSER == "MicrosoftEdge" ]; then
  exit 0
fi
if [ $BROWSER == "Electron" ]; then
  exit 0
fi
if [ $BROWSER == "NodeWebkit" ]; then
  exit 0
fi
if [ $BVER == "android" ]; then
  exit 0
fi
if [ -z $BVER ]; then
  exit 0
fi
# determine the script path
# ref: http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

# get the browser version string
case $OSTYPE in
  darwin*) PLATFORM="mac";;
  linux*) PLATFORM="linux";;
esac

VERSION_REGEX="[0-9]+(\.[0-9]+)*"
if [[ $BVER =~ $VERSION_REGEX ]] ; then
 echo "BVER is a version number so going to install a specific version"
 if [ $BROWSER == 'firefox' ] ; then
   TARGET_URL="http://download.cdn.mozilla.net/pub/firefox/releases/$BVER/linux-x86_64/en-US/firefox-$BVER.tar.bz2"
 elif [ $BROWSER == 'chrome' ] ; then
   TARGET_URL="http://www.slimjet.com/chrome/lnx/chrome64_$BVER.deb"
 else
   echo "Installing specific versions only works for Chrome or Firefox"
 fi
 TARGET_VERSION=$BVER
elif [ $BROWSER == "safari" ] && [ $BVER == "unstable" ]; then
  # This is quite dangerous, it is scraping the safari download website for the URL. If the format
  # of the website changes then it won't work anymore. We should add safari to
  # browsers.contralis.info instead
  TARGET_URL=`curl https://developer.apple.com/safari/download/ | sed -nE 's/.*href="(.*\.dmg)">.*macOS 10.12.*/\1/p'`
  TARGET_VERSION=`curl https://developer.apple.com/safari/download/ | sed -nE 's/.*>([0-9]+)<\/p>.*$/\1/p'`
else
  TARGET_BROWSER=`curl -H 'Accept: text/csv' https://browser-version-api.herokuapp.com/$PLATFORM/$BROWSER/$BVER`
  TARGET_URL=`echo $TARGET_BROWSER | cut -d',' -f7`
  TARGET_VERSION=`echo $TARGET_BROWSER | cut -d',' -f5`
fi
TARGET_PATH=$SCRIPTPATH/browsers/$BROWSER/$TARGET_VERSION

# make the local bin directory and include it in the path
BINPATH=./browsers/bin
mkdir -p $BINPATH

# install if required
if [ ! -d $TARGET_PATH ]; then
  echo "getting $BROWSER $TARGET_VERSION from $TARGET_URL"
  source $SCRIPTPATH/install-$BROWSER.sh "$TARGET_URL" "$TARGET_PATH"
fi

# create the symbolic links
case $BROWSER in
  chrome)
    ln -sf $TARGET_PATH/chrome $BINPATH/chrome-$BVER
    $BINPATH/chrome-$BVER --version
    ;;
  firefox)
    ln -sf $TARGET_PATH/firefox $BINPATH/firefox-$BVER
    $BINPATH/firefox-$BVER --version
    ;;
  safari)
    if [ $BVER == "unstable" ]; then
      mdls -name kMDItemVersion /Applications/Safari\ Technology\ Preview.app
    else
      mdls -name kMDItemVersion /Applications/Safari.app
    fi
    ;;
esac
