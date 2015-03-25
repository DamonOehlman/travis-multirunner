#!/usr/bin/env bash
set -x
set -e

# determine the script path
# ref: http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

# firefox base details
source $SCRIPTPATH/firefox-versions.sh

# setup the virtual environment
# as per: https://github.com/mozilla-b2g/gaia/blob/master/.travis.yml#L3
# source $SCRIPTPATH/venv.sh

uname -a
cat /etc/lsb-release

# create the local user bin path
mkdir -p ~/bin
export PATH=~/bin:$PATH

echo "Getting $BVER version of $BROWSER"
source browsers/$BROWSER.sh

# setup the loopback video
# ./setup-loopbackvideo.sh
