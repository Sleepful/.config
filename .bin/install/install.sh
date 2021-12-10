#!/bin/bash
source ./dirs.sh

# OMZ
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm ~/.zshrc
cfg restore .zshrc

# Font
brew tap homebrew/cask-fonts
brew install --cask font-iosevka
# To search for other variants:
# brew search font-iosevka
# Example download:
# brew install --cask font-iosevka-curly-slab

# Doom requisites
brew install ripgrep
brew install findutils
brew install coreutils
# Emacs
brew install --no-quarantine emacs --HEAD
/usr/bin/tic -x -o ~/.terminfo ~/.bin/install/config/terminfo-custom.src
# Doom
rm -rf ~/.emacs.d
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

# Delete pre-push and pre-commit from ~/.githooks if still there

# Karabiner
brew install --cask karabiner-elements

# node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
## Temporary NVM vars for the following commands...
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install 14
# nvm alias default 14
nvm use node

# elixir
brew install asdf
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf install erlang latest
asdf install elixir latest
asdf global erlang latest
asdf global elixir latest

# psql
# install postgresql
# install from postgres.app for osx

# create some dirs
source ./dirs.sh
