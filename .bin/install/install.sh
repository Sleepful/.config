#!/bin/bash
source ./dirs.sh

# OMZ
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm ~/.zshrc
cfg restore .zshrc

# Emacs
brew install --no-quarantine emacs --HEAD
/usr/bin/tic -x -o ~/.terminfo ~/.bin/install/config/terminfo-custom.src
# Doom
rm -rf ~/.emacs.d
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

# node
brew install nvm
mkdir ~/.nvm

# elixir
brew install asdf

# create some dirs
source ./dirs.sh
