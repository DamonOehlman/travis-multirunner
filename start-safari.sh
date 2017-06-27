#!/usr/bin/env bash

if [ $BVER == "unstable" ]; then
  open -a "Safari Technology Preview" $@
else
  open -a "Safari" $@
fi
