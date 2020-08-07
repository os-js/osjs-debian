#!/usr/bin/env bash
set -e

dest="build/live"

echo "*** Making Live Image ***"

if [[ -d $dest ]]; then
  rm -rf $dest
fi

mkdir -p $dest
cd $dest
lb config
lb build

mv $dest/live-image-amd64.hybrid.iso build/
