#!/usr/bin/env bash
set -e

live="live-default"

echo "*** Making Live Image ***"

if [[ -d $live ]]; then
  rm -rf $live
fi

mkdir -p $live
cd $live
lb config
lb build
