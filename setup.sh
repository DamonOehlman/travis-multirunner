#!/usr/bin/env bash
set -x
set -e

# determine the script path
# ref: http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

# get the browser version string
TARGET_BROWSER=`./node_modules/.bin/browser-version $BROWSER $BVER`
TARGET_URL=`echo $TARGET_BROWSER | cut -d'|' -f4`
TARGET_VERSION=`echo $TARGET_BROWSER | cut -d'|' -f3`
TARGET_PATH=~/browsers/$BROWSER/$TARGET_VERSION

# make the local bin directory and include it in the path
mkdir -p ~/bin
export PATH=~/bin:$PATH

# setup the virtual environment
# as per: https://github.com/mozilla-b2g/gaia/blob/master/.travis.yml#L3
# source $SCRIPTPATH/venv.sh

# uname -a
# cat /etc/lsb-release

# install if required
if [ ! -d $TARGET_PATH ]; then
  echo "getting $BROWSER $TARGET_VERSION"
  source ./install-$BROWSER.sh "$TARGET_URL" "$TARGET_PATH"
fi

# create the symbolic links
case $BROWSER in
  chrome)
    ln -sf $TARGET_PATH/google-chrome ~/bin/google-chrome
    ;;
  firefox)
    ln -sf $TARGET_PATH/firefox ~/bin/firefox
    ;;
esac

# # create the local user bin path
# mkdir -p ~/bin
# export PATH=~/bin:$PATH
# 
# echo "Getting $BVER version of $BROWSER"
# source browsers/$BROWSER.sh

# setup the loopback video
# ./setup-loopbackvideo.sh
