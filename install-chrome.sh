#!/usr/bin/env bash
FNAME=`echo $1 | sed -r "s/^.*\/([^\/]*)$/\1/"`

# cleanup any old files (shouldn't happen on travis)
rm -rf $FNAME
rm -rf ./browser-tmp

# get the files
wget $1
dpkg -X $FNAME ./browser-tmp

# make the target directory
mkdir -p $2
mv ./browser-tmp/opt/google/chrome*/* $2