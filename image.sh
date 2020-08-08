#!/usr/bin/env bash
#
# @author Anders Evenrud <<andersevenrud@gmail.com>
# @license MIT
#
set -e

cwd=$(pwd)
arch=$(dpkg --print-architecture)
dest="build/live"
package_name="osjs"
package_version=$(cat package.json | jq -r ".version")
package_filename="$package_name-$package_version"

uname -a
lsb_release -a
echo "*** Making Live Image ***"

if [[ -d $dest ]]; then
  rm -rf $dest
fi

echo "Setting up directories..."
mkdir -p $dest

echo "Configuring live image..."
pushd $dest
  lb config -b iso --memtest none --distribution buster
  cp ../${package_filename}_${arch}.deb config/packages.chroot/
  cp ${cwd}/src/osjs.list.* config/package-lists/
  cp ${cwd}/src/osjs.hook.* config/hooks/live/
popd

echo "Building live image..."
pushd $dest
  lb build
popd

mv $dest/live-image-${arch}.iso build/
