#!/usr/bin/env bash
FNAME=`echo $1 | sed -r "s/^.*\/([^\/]*)$/\1/"`

# cleanup any old files (shouldn't happen on travis)
rm -rf $FNAME
rm -rf ./browser-tmp
mkdir -p ./browser-tmp

# get the files
wget -q $1
tar xvf $FNAME --directory ./browser-tmp

# # make the target directory
mkdir -p $2
mv ./browser-tmp/firefox/* $2
rm -rf ./browser-tmp
