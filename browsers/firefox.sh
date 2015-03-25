#!/usr/bin/env bash
mkdir -p ~/firefox/$BVER
wget ${FIREFOX_VERSIONS[$BVER]} -O firefox.tar.bz2
tar xjf firefox.tar.bz2 --strip-components=1 --directory ~/firefox/$BVER
ln ~/firefox/$BVER/firefox ~/bin/firefox -s

which firefox
ls -l `which firefox`
firefox --version
;;