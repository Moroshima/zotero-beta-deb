#!/bin/bash
set -euo pipefail

PWD=$(pwd)

sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install -y gcc-multilib g++-multilib libdbus-glib-1-dev:i386 \
  libgtk2.0-dev:i386 libgtk-3-dev:i386 libpango1.0-dev:i386 libxt-dev:i386 \
  libx11-xcb-dev:i386 libpulse-dev:i386 libdrm-dev:i386
