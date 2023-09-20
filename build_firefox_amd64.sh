#!/bin/bash
set -euo pipefail

GECKO_VERSION='102.13.0esr'

# firefox debian common packages deps
sudo apt -y build-essential libpython3-dev m4 unzip uuid zip
# firefox debian browser common packages deps
sudo apt -y libasound2-dev libcurl4-openssl-dev libdbus-1-dev libdbus-glib-1-dev libdrm-dev libgtk-3-dev libpulse-dev libx11-xcb-dev libxt-dev xvfb
# mach build deps
sudo apt -y rustc cargo cbindgen llvm clang nasm
# mozconfig deps (libpng does not support apng, so we have to use firefox's libpng)
sudo apt -y libnspr4-dev libvpx-dev libnss3-dev libevent-dev

git clone https://ftp.mozilla.org/pub/firefox/releases/$GECKO_VERSION/source/firefox-$GECKO_VERSION.source.tar.xz
tar -xvf firefox-102.13.0esr.source.tar.xz

PURE_GECKO_VERSION=${GECKO_VERSION//esr/}
cd "firefox-$PURE_GECKO_VERSION"

# set mozconfig build options
./set_mozconfig.sh

# make .mozbuild folder for firefox build cache
mkdir .mozbuild

MOZCONFIG=./mozconfig MOZBUILD_STATE_PATH=./.mozbuild ./mach build
