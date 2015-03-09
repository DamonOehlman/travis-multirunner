#!/usr/bin/env bash
set -x
set -e

# Make sure /dev/shm has correct permissions.
ls -l /dev/shm
sudo chmod 1777 /dev/shm
ls -l /dev/shm

# determine the script path
# ref: http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

# firefox base details
source $SCRIPTPATH/firefox-versions.sh

# setup the virtual environment
# as per: https://github.com/mozilla-b2g/gaia/blob/master/.travis.yml#L3
source $SCRIPTPATH/venv.sh

uname -a
cat /etc/lsb-release

sudo apt-get update --fix-missing
echo "Getting $BVER version of $BROWSER"

case $BROWSER in
android)
  sudo apt-get install -qq --force-yes \
    libc6:i386 libgcc1:i386 gcc-4.6-base:i386 libstdc++5:i386 \
    libstdc++6:i386 lib32z1 libreadline6-dev:i386 \
    libncurses5-dev:i386
  bash tools/android/setup.sh
  ;;

chrome)
  export CHROME=google-chrome-${BVER}_current_amd64.deb
  wget https://dl.google.com/linux/direct/$CHROME
  sudo dpkg --install $CHROME || sudo apt-get -f install
  which google-chrome
  ls -l `which google-chrome`

  if [ -f /opt/google/chrome/chrome-sandbox ]; then
    export CHROME_SANDBOX=/opt/google/chrome/chrome-sandbox
  else
    export CHROME_SANDBOX=$(ls /opt/google/chrome*/chrome-sandbox)
  fi

  # Download a custom chrome-sandbox which works inside OpenVC containers (used on travis).
  sudo rm -f $CHROME_SANDBOX
  sudo wget https://googledrive.com/host/0B5VlNZ_Rvdw6NTJoZDBSVy1ZdkE -O $CHROME_SANDBOX
  sudo chown root:root $CHROME_SANDBOX; sudo chmod 4755 $CHROME_SANDBOX
  sudo md5sum $CHROME_SANDBOX

  google-chrome --version
  ;;

firefox)
  sudo rm -f /usr/local/bin/firefox
  sudo apt-get install pulseaudio

  sudo mkdir -p /opt/firefox/$BVER
  sudo chown $USER:$USER /opt/firefox/$BVER
  wget ${FIREFOX_VERSIONS[$BVER]} -O firefox.tar.bz2
  tar xjf firefox.tar.bz2 --strip-components=1 --directory /opt/firefox/$BVER
  sudo ln /opt/firefox/$BVER/firefox /usr/local/bin/firefox -s

  which firefox
  ls -l `which firefox`
  firefox --version
  ;;
esac

# setup the loopback video
# ./setup-loopbackvideo.sh
