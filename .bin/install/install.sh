#!/bin/bash
source ./dirs.sh

# OMZ
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm ~/.zshrc
cfg restore .zshrc

# Emacs
brew install --no-quarantine emacs --HEAD
tic -x -o ~/.terminfo terminfo-custom.src

# node
brew install nvm
source ./dirs.sh
