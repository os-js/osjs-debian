#!/usr/bin/env bash
set -e

dest="build/live"

echo "*** Making Live Image ***"

if [[ -d $dest ]]; then
  rm -rf $dest
fi

echo "Setting up directories..."
mkdir -p $dest

echo "Configuring live image..."
pushd $dest
  lb config -b iso --memtest none
  cp ../*.deb config/packages.chroot/
  echo "xorg" >> config/package-lists/osjs.list.chroot
  echo "nodejs" >> config/package-lists/osjs.list.chroot
popd

echo "Building live image..."
pushd $dest
  lb build
popd

mv $dest/live-image-amd64.iso build/
