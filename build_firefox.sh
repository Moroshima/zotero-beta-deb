#!/bin/bash
set -euo pipefail

sudo apt build-essential libpython3-dev m4 unzip uuid zip libasound2-dev libcurl4-openssl-dev libdbus-1-dev libdbus-glib-1-dev libdrm-dev libgtk-3-dev libpulse-dev libx11-xcb-dev libxt-dev xvfb rustc cargo cbindgen llvm clang nasm

git clone https://ftp.mozilla.org/pub/firefox/releases/102.13.0esr/source/firefox-102.13.0esr.source.tar.xz
tar -xvf firefox-102.13.0esr.source.tar.xz

cd firefox-102.13.0

mkdir .mozbuild
export MOZBUILD_STATE_PATH=./.mozbuild

echo "# My first mozilla config
ac_add_options --without-wasm-sandboxed-libraries
ac_add_options --enable-release" > mozconfig
export MOZCONFIG=./mozconfig

./mach build
