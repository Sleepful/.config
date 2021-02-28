
# MacPorts Installer addition on 2020-11-05_at_09:38:36: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

export PATH=~/.emacs.d/bin:$PATH
export PATH="$HOME/.bin:$PATH"
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cfgsetup='cfg config status.showuntrackedfiles no'
alias g='git'

# cds
alias code='cd ~/Code'
alias notes='cd ~/Notes'
alias lang='cd ~/Language'
alias vrc='vim ~/.vimrc'
alias vim='vim -S ~/.vimrc' # necessary only if using neovim, as neovim reads the config from somewhere else
alias kdir='cd ~/Code/GitBuilds/kitty'
# anki
alias ankicm='cd /Users/corporatejose/Library/Application\ Support/Anki2/User\ 1/collection.media'
alias anki='cd /Users/corporatejose/Documents/Anki'
# others
alias bf='cd ~/Code/brightflow-connectors'

# emacs
alias emak='TERM=xterm-emacs emacs -nw'
alias emac='TERM=xterm-emacs-kitty emacs -nw'
alias ec='TERM=xterm-emacs-kitty emacsclient -nw'
alias ee='ec -e "(progn (+workspace:delete)(+workspace/switch-to-final))"'
function es(){
  emacsclient -n $@
}
function ek(){
  emacsclient -n $@ && ec $_
}
alias pkec="pkill emacs"
alias zrc='ec ~/.zshrc'
alias prc='ec ~/.profile'
alias krc='ec ~/.config/kitty/kitty.conf'
# used for emacsclient..i think? *doubt*
export ALTERNATE_EDITOR=""
export EDITOR="TERM=xterm-emacs-kitty emacsclient -nw"                  # $EDITOR opens in terminal
# used in emacs .config
alias jslsp='node ~/Code/Forks/javascript-typescript-langserver/lib/language-server-stdio'

# utility
alias py='python3'
alias lsbin='ls ~/.bin'
alias bin='cd ~/.bin'
function prcg(){ #TODO: this one still doesn't work
  grep -A 4 -B 1 -- "$@" ~/.profile
}



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
