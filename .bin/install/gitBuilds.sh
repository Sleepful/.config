#!/bin/bash
EmacsDIR=~/Code/GitBuilds/emacs
git clone --depth 1 --branch emacs-27 https://git.savannah.gnu.org/emacs.git $EmacsDIR
# apt-get build-dep might need to uncomment some repo source things
sudo sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
sudo apt-get update
# those lines above should uncomment the lines needed for build-dep
sudo apt-get build-dep emacs
$EmacsDIR/autogen.sh
sudo apt install libjansson-dev # necessary for json support
$EmacsDIR/configure.sh --with-imagemagick --with-json
make $EmacsDIR
sudo make install $EmacsDIR

