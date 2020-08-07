#!/usr/bin/env bash
set -e

root=$(pwd)
dest="build/deb"
osjs="$dest/opt/osjs"
package_name="osjs"
package_version=$(cat package.json | jq -r ".version")
package_filename="$package_name-$package_version"

echo "*** Starting creation of $package_filename ***"

echo "Setting up directories..."

if [[ -d $dest ]]; then
  rm -rf $dest
fi

mkdir -p $osjs/bin $live

echo "Installing required packages..."

npm install --no-progress
npm update --no-progress
npm run package:discover -- --copy

echo "Building solutions..."

NODE_ENV=production npm run build -- --display minimal

echo "Copying files..."

cp -r dist $osjs/
cp -r node_modules $osjs/
cp -r src/server $osjs/
cp -r src/debian $dest/DEBIAN
cp packages.json $osjs/
cp bin/run.sh $osjs/bin/
cp bin/run-electron.sh $osjs/bin/
echo "https://github.com/os-js/OS.js" > $osjs/README
cp LICENSE $osjs/
cp -r src/etc $dest/
sed -i "s/VERSION/${package_version}/g" $dest/DEBIAN/control

echo "Pruning node dependencies..."

pushd $osjs
  NODE_ENV=production npm prune
  modclean -r
popd

echo "Making debian package..."

dpkg-deb --build $dest "build/${package_filename}.deb"
