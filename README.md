# osjs-debian

This repository builds a `.deb` package and `.iso` live image for Debian.

**Currently only produces x86 builds**

## Requirements

You only need docker.

## Usage

Build files and output files are located in `build/`.

First you have to create the base image that contains all tools to build:

```
# This is only performed once to create a local Docker imag
$ docker build -t osjs/debian .
```

Then use one of the following build scripts:

> NOTE: Builds are always fresh. Temporary files between runs are removed.

```
# Build debian package
$ docker run --privileged -v "${PWD}:/usr/src/osjs" osjs/debian bin/build.sh

# Build live ISO image
$ docker run --privileged -v "${PWD}:/usr/src/osjs" osjs/debian bin/image.sh
```

## Links

- https://github.com/os-js/OS.js
- https://www.devdungeon.com/content/debian-package-tutorial-dpkgdeb
- https://live-team.pages.debian.net/live-manual/html/live-manual/index.en.html
