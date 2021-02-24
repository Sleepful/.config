
# MacPorts Installer addition on 2020-11-05_at_09:38:36: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

export PATH=~/.emacs.d/bin:$PATH
export PATH="$HOME/.bin:$PATH"
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cfgsetup='cfg config status.showuntrackedfiles no'
alias g='git'
alias code='cd ~/Code'
alias notes='cd ~/Notes'
alias lang='cd ~/Language'
alias jslsp='node ~/Code/Forks/javascript-typescript-langserver/lib/language-server-stdio'
alias vrc='vim ~/.vimrc'
alias vim='vim -S ~/.vimrc' # necessary only if using neovim, as neovim reads the config from somewhere else

alias emak='TERM=xterm-emacs emacs -nw'
alias emac='TERM=xterm-emacs-kitty emacs -nw'
alias ec='TERM=xterm-emacs-kitty emacsclient -nw'
function ecn(){
  emacsclient -n "$@" 
}
function ecnc(){
  emacsclient -n -c "$@"
}
alias zrc='ec ~/.zshrc'
alias prc='ec ~/.profile'
export ALTERNATE_EDITOR=""
export EDITOR="TERM=xterm-emacs-kitty emacsclient -nw"                  # $EDITOR opens in terminal

alias py='python3'

alias kittyconf='vim ~/.config/kitty/kitty.conf'

## Anki
alias ankicm='cd /Users/corporatejose/Library/Application\ Support/Anki2/User\ 1/collection.media'
alias anki='cd /Users/corporatejose/Documents/Anki'

#others
alias bf='cd ~/Code/brightflow-connectors'

### scripty

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if ! ps -e -o args | grep -q '^emacs --daemon$'; then
  emacs --daemon
else
  echo "Emacs server Online"
fi
