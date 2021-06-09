
# MacPorts Installer addition on 2020-11-05_at_09:38:36: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

export PATH=~/.emacs.d/bin:$PATH
export PATH="$HOME/.bin:$PATH"
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cfgsetup='cfg config status.showuntrackedfiles no'
alias g='git'

alias sprc='source ~/.profile'
# cds
alias code='cd ~/Code'
alias notes='cd ~/Notes'
alias lang='cd ~/Language'
alias vrc='vim ~/.vimrc'
alias vim='vim -S ~/.vimrc' # necessary only if using neovim, as neovim reads the config from somewhere else
alias kdir='cd ~/Code/GitBuilds/kitty'
alias ktdir='cd ~/Code/GitBuilds/kitty-themes/themes'
alias gbs='cd ~/Code/GitBuilds'
# macOs
# anki
alias ankicm='cd ~/Library/Application\ Support/Anki2/User\ 1/collection.media'
alias anki='cd ~/Documents/Anki'

# others
alias bf='cd ~/Code/brightflow-connectors'
alias bfng='ngrok http  31111 -subdomain=josesesesej'
alias bfsyncdev='NODE_ENV=development node ./dist/src/scripts/schedule-connection-sync.js 9ddcc9d0-861d-11eb-b582-acde48001122'
alias bfsync='cd ~/Code/brightflow-connectors && DATABASE_URL=postgres:///brightflow_transient NODE_ENV=development node ./dist/src/scripts/schedule-connection-sync.js 9ddcc9d0-861d-11eb-b582-acde48001122'
alias syncFatheadDemo='DATABASE_URL=postgres://llkjfxvozllwuu:2df24abccecc363e62721a6cb5b85db70984dbd28813c78dca07df0c9e46aabc@ec2-3-215-83-17.compute-1.amazonaws.com:5432/dat523sdrq5o2j?ssl=no-verify REDIS_URL=redis://h:p96cfbb543721df3fc23c0d42cb3b2a1d4d2b42c9559d9702e76f58ac5d2e5c47@ec2-54-224-29-217.compute-1.amazonaws.com:32419 LOG_LEVEL=verbose NODE_ENV=development node ./dist/src/scripts/schedule-connection-sync.js 2b65e55e-8db0-11eb-bc23-06f8a6f10a7d'
alias syncProdFathead='cd ~/Code/brightflow-connectors && DATABASE_URL=postgres:///brightflow_transient NODE_ENV=development node ./dist/src/scripts/schedule-connection-sync.js  721c35c0-5cdc-11eb-86b0-1205f89b288d'

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
alias pke="pkill emacs"
alias zrc='ec ~/.zshrc'
alias prc='ec ~/.profile'
alias krc='ec ~/.config/kitty/kitty.conf'
# used for emacsclient..i think? *doubt*
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -nw"                  # $EDITOR opens in terminal
# used in emacs .config
alias jslsp='node ~/Code/Forks/javascript-typescript-langserver/lib/language-server-stdio'

# utility
alias py='python3'
alias lsbin='ls ~/.bin'
alias bin='cd ~/.bin'
function prcg(){
  # Stolen version does work
  more ~/.profile | grep -b1 -a4 $1
  # My version does not work
  # grep -A 4 -B 1 -- "$@" ~/.profile
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

alias org='cd ~/Code/orgzly'
alias ngdav='ngrok http 80 -subdomain=orgzlying'
function npmdav(){
  sudo echo -n "WebDav Password: "
  read -s password
  echo
  if [ -z "$password" ]; then
     echo "Password cannot be empty..."
  else
    sudo npx webdav-cli --port 80 --username admin --password $password
  fi
}
alias webdav='ngdav > /dev/null & npmdav'
alias kbg="pgrep -P $$ | head -n -2 | sudo xargs kill && fg"

