#!/bin/bash
set -euo pipefail

GECKO_RELEASE='102.13.0esr'
GECKO_VERSION=${GECKO_RELEASE//esr/}

ROOT_DIR=$(pwd)
FIREFOX_SOURCE_DIR=$ROOT_DIR/firefox-$GECKO_VERSION

# basic tools
sudo apt-get install -y wget gcc g++ make python3 nodejs npm
# firefox debian common packages deps
sudo apt-get install -y build-essential libpython3-dev m4 unzip uuid zip
# firefox debian browser common packages deps
sudo apt-get install -y libasound2-dev libcurl4-openssl-dev libdbus-1-dev libdbus-glib-1-dev \
  libdrm-dev libgtk-3-dev libpulse-dev libx11-xcb-dev libxt-dev xvfb
# mach build deps
sudo apt-get install -y rustc cargo cbindgen llvm clang nasm
# mozconfig deps (libpng does not support apng, so we have to use firefox's libpng)
sudo apt-get install -y libnspr4-dev libvpx-dev libnss3-dev libevent-dev
echo "========================================================================"

if [ ! -f "$ROOT_DIR/firefox-$GECKO_RELEASE.source.tar.xz" ]; then
  echo "firefox-$GECKO_RELEASE.source.tar.xz not found, downloading..."
  wget https://ftp.mozilla.org/pub/firefox/releases/$GECKO_RELEASE/source/firefox-$GECKO_RELEASE.source.tar.xz
  echo "========================================================================"
else
  echo "firefox-$GECKO_RELEASE.source.tar.xz found, skipping download."
  echo "========================================================================"
fi

if [ -e "$FIREFOX_SOURCE_DIR" ]; then
  echo "$FIREFOX_SOURCE_DIR found, skipping extract."
  echo "========================================================================"
else
  echo "$FIREFOX_SOURCE_DIR not found, extracting..."
  tar -xvf firefox-$GECKO_RELEASE.source.tar.xz
  echo "========================================================================"
fi

cd "$FIREFOX_SOURCE_DIR"

# make .mozbuild folder for firefox build cache
mkdir -p "$ROOT_DIR/.mozbuild"

export MOZCONFIG=$ROOT_DIR/mozconfig
export MOZBUILD_STATE_PATH=$ROOT_DIR/.mozbuild

echo "Start building Firefox $GECKO_RELEASE x86_64..."
./mach build
echo "========================================================================"
echo "Start packaging Firefox $GECKO_RELEASE x86_64..."
./mach package
echo "========================================================================"

unset MOZCONFIG MOZBUILD_STATE_PATH

if [ ! -f "$FIREFOX_SOURCE_DIR/firefox-build-dir/dist/firefox-$GECKO_VERSION.en-US.linux-x86_64.tar.bz2" ]; then
  cp -f "$FIREFOX_SOURCE_DIR/firefox-build-dir/dist/firefox-$GECKO_VERSION.en-US.linux-x86_64.tar.bz2" "$ROOT_DIR/"
else
  echo "firefox-$GECKO_VERSION.en-US.linux-x86_64.tar.bz2 not found, there is something wrong during building process"
  exit 1
fi

echo "Success! Firefox $GECKO_RELEASE x86_64 building progress done."
