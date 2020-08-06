<p align="center">
  <img alt="OS.js Logo" src="https://raw.githubusercontent.com/os-js/gfx/master/logo-big.png" />
</p>

# OS.js v3 Debian Package

[OS.js](https://www.os-js.org/) is an [open-source](https://raw.githubusercontent.com/os-js/OS.js/master/LICENSE) desktop implementation for your browser with a fully-fledged window manager, Application APIs, GUI toolkits and filesystem abstraction.

[![Support](https://img.shields.io/badge/patreon-support-orange.svg)](https://www.patreon.com/user?u=2978551&ty=h&u=2978551)
[![Back](https://opencollective.com/osjs/tiers/backer/badge.svg?label=backer&color=brightgreen)](https://opencollective.com/osjs)
[![Sponsor](https://opencollective.com/osjs/tiers/sponsor/badge.svg?label=sponsor&color=brightgreen)](https://opencollective.com/osjs)
[![Donate](https://img.shields.io/badge/liberapay-donate-yellowgreen.svg)](https://liberapay.com/os-js/)
[![Donate](https://img.shields.io/badge/paypal-donate-yellow.svg)](https://paypal.me/andersevenrud)
[![Community](https://img.shields.io/badge/join-community-green.svg)](https://community.os-js.org/)

## Introduction

This repository builds a `.deb` package (with Docker) you can install OS.js on a Debian/Ubuntu system directly.

Contains a custom OS.js distro build and provides a systemd unit that starts the server upon boot.

*You can use this as a template for making deployments on embedded platforms etc.*

## Requirements

You only need docker. Works on any host system.

## Usage

```
Build the initial base image
$ docker build -t osjs/debian .

Build OS.js
$ docker run -v "${PWD}:/usr/src/osjs" osjs/debian bin/build.sh
```

The `build/` directory contains the sources of the built package.

## Development

When the docker image builds the package, `NODE_ENV` is set to `production` which will enable features only applicable to the debian environment.

This way you can still develop changes without using a live environment.

The only chaveat is that the docker image shares the storage volume with the root directory, so you have wo wipe `node_modules/` before running it on your host system.

The version number is set from `package.json`.

## Info

The debian package installs into `/opt/osjs`.

The resulting build has been pruned, so it's a bit more lightweight than a "regular installation".

## TODO

- [ ] Add multiple arch

## Contribution

* **Become a [Patreon](https://www.patreon.com/user?u=2978551&ty=h&u=2978551)**
* **Support on [Open Collective](https://opencollective.com/osjs)**
* [Contribution Guide](https://github.com/os-js/OS.js/blob/v3/CONTRIBUTING.md)

## Documentation

See the [Official Manuals](https://manual.os-js.org/v3/) for articles, tutorials and guides.

## Links

* [Official Chat](https://gitter.im/os-js/OS.js)
* [Community Forums and Announcements](https://community.os-js.org/)
* [Homepage](https://os-js.org/)
* [Twitter](https://twitter.com/osjsorg) ([author](https://twitter.com/andersevenrud))
* [Google+](https://plus.google.com/b/113399210633478618934/113399210633478618934)
* [Facebook](https://www.facebook.com/os.js.org)
* [Docker Hub](https://hub.docker.com/u/osjs/)
