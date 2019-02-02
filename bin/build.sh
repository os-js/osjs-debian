#!/usr/bin/env bash
set -e

root=$(pwd)
dest="build"
osjs="$dest/opt/osjs"
package_name="osjs"
package_version=$(cat package.json | jq -r ".version")
package_filename="$package_name-$package_version"

echo "*** Starting creation of $package_filename ***"

echo "Setting up directories..."

if [[ -d build ]]; then
  rm -rf build/
fi

mkdir -p $osjs/bin
mkdir -p $osjs/src
mkdir -p $dest/etc/systemd/system

echo "Building..."

npm install --no-progress
npm run package:discover -- --copy &> /dev/null
NODE_ENV=production npm run build &> /dev/null

echo "Copying image files..."

set -x
cp -r dist $osjs/
cp -r node_modules $osjs/
cp -r src/client $osjs/src/
cp -r src/server $osjs/src/
cp -r src/debian $dest/DEBIAN
cp packages.json $osjs/
cp package.json $osjs/
cp package-lock.json $osjs/
cp bin/run.sh $osjs/bin/
cp README.md $osjs/
cp LICENSE $osjs/
cp src/osjs.service $dest/etc/systemd/system/
sed -i "s/VERSION/${package_version}/g" $dest/DEBIAN/control
set +x

echo "Pruning target..."

pushd $osjs
  NODE_ENV=production npm prune
  modclean -r
popd

echo "Making deb..."

dpkg-deb --build $dest "${package_filename}.deb"

echo "Done (${package_filename}.deb) :)"
