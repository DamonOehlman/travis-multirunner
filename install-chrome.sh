#!/usr/bin/env bash
# Install chrome.
# Arguments: $1=target URL, $2=target path
#
# The script expects to run in the script home dir, and uses
# the subdir "browser-tmp" as a temporary directory.
#
FNAME=`echo $1 | sed -r "s/^.*\/([^\/]*)$/\1/"`

# cleanup any old files (shouldn't happen on travis)
rm -rf ./browser-tmp
mkdir ./browser-tmp

# get the files
(cd ./browser-tmp; wget -q $1)
dpkg -X ./browser-tmp/$FNAME ./browser-tmp

# remove the broken link
rm -rf ./browser-tmp/opt/google/chrome*/google-chrome

# make the target directory
mkdir -p $2
mv ./browser-tmp/opt/google/chrome*/* $2
rm -rf ./browser-tmp
