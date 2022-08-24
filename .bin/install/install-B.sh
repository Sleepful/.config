# Meh
brew install --cask vscodium

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
brew install gnu-sed
# Emacs
brew install --no-quarantine emacs --HEAD
/usr/bin/tic -x -o ~/.terminfo ~/.bin/install/config/terminfo-custom.src
# Doom
rm -rf ~/.emacs.d
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
# Delete pre-push and pre-commit from ~/.githooks if still there
# (doom bug?)

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
npm install --global prettier
npm install --global yarn

# python
brew install pyenv
# install python through pyenv, pick the version
pyenv install 3.10.0
pyenv global 3.10.0
pip install termdown

# psql
# install postgresql
# install from postgres.app for osx

# create some dirs
source ./dirs.sh

# generate ENV variables for Doom
zsh -c "doom env"

# Zsh vi plugin
git clone https://github.com/jeffreytse/zsh-vi-mode.git $HOME/.config/zsh/.zsh-vi-mode

# eye care
brew install --cask flux

# Others
# On OSX there are some shortcuts to be removed
# they are removed by replacing them with impossible shortcuts
# Preferences -> Keyboard -> Shortcuts -> +
# Add the following:
# Ctrl+M on terminal
# Hide kitty : random shortcut that will never get triggered
# Ctrl+H on every app
# Minimize   : random shortcut that will never get triggered

# Go
brew install go
# Go lsp server
go install golang.org/x/tools/gopls@latest
# go env GOPATH
