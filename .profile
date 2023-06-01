# MacPorts Installer addition on 2020-11-05_at_09:38:36: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# Finished adapting your PATH environment variable for use with MacPorts.

export PATH="/opt/homebrew/bin:$PATH"
export PATH=~/.emacs.d/bin:$PATH
export PATH="$HOME/.bin:$PATH"
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cfgsetup='cfg config status.showuntrackedfiles no'
alias g='git'

alias sprc='source ~/.profile'
alias szrc='source ~/.zshrc'
alias ssecret='source ~/.secret'
# cds
alias code='cd ~/Code'
alias oa='cd ~/Code/OA'
alias wb='cd ~/Code/WordDatabase/phx'
alias conf='cd ~/.config'
alias notes='cd ~/Notes'
alias lang='cd ~/Language'
# neovim
export PATH="$HOME/local/nvim/bin:$PATH"
alias vim='nvim'
alias vrc='nvim ~/.vimrc'
alias vimconf='cd ~/.config/nvim'
alias vimf='vim $(`fc -ln -1`)'
alias vimr='vim README.md'

# some dirs?
alias kdir='cd ~/Code/GitBuilds/kitty'
alias ktdir='cd ~/Code/GitBuilds/kitty-themes/themes'
alias gbs='cd ~/Code/GitBuilds'

# tmux
alias tm='tmux'
alias tmrc='vim ~/.tmux.conf'

jump() {
	# switch session and kill previous one
	session_to_discard=$(tmux display -p '#S')
	tm detach -E "tmux attach -t $1"
	tm kill-session -t $current_session
}

switch() {
	# switch session
	tm detach -E "tmux attach -t $1"
}

pws() {
	# prints current session
	echo $(tmux display -p '#S')
}
# macOs
alias rmDS='find . -name ".DS_Store" -delete'
# anki
alias ankicm='cd ~/Library/Application\ Support/Anki2/User\ 1/collection.media'
alias anki='cd ~/Documents/Anki'
# termdown
function pomo() {
	termdown "$@" && tput bel && terminal-notifier -message "$@ pomo complete"
}

# git
function gcorb() {
	git checkout -b release/$(date +%+4Y.%m.%d)-r$@
}
function gcr() {
	git commit -m "prepare release $(date +%+4Y.%m.%d)-r$@"
}
function gtr() {
	git tag $(date +%+4Y.%m.%d)-r$@
}
alias gpt='git push --tags'
# Postgres MACOS stuff
alias clearpgpid='pkill postgres && rm ~/Library/Application Support/Postgres/var-13/postmaster.pid'
# Npm/Yarn MACOS stuff
alias fixgyp="sudo rm -r -f $(xcode-select --print-path) \
  && xcode-select --install"

alias psf='ps aux | grep -i'
# others
alias h='echo "head .git/HEAD" | pbcopy'
alias localdb='DATABASE_URL=postgres://postgres:postgres@localhost:5432/brightflow_development'
alias stagedb='DATABASE_URL=$(echo "`heroku pg:credentials:url --remote staging | grep postgres | sed "s: ::g" | tr -s \\n `?ssl=no-verify")'
alias stageredis='REDIS_URL=`heroku redis:credentials --remote staging`'
alias stageall=$'eval $(heroku config --remote staging | tail -n +2 | sed "s/\:[[:blank:]]*\\(.*\\)/=\'\\1\'/g" | tr "\n" " ")' #"
# alias bfstaging2='eval $(heroku config --remote staging | tail -n +2 | sed "s/\:[[:blank:]]*\(.*\)/='\''\1'\''/g" | tr "\n" " ")'
alias proddb='DATABASE_URL=$(echo "`heroku pg:credentials:url --remote production | grep postgres | sed "s: ::g" | tr -s \\n `?ssl=no-verify")'
alias prodredis='REDIS_URL=`heroku redis:credentials --remote production`'
alias prodall=$'eval $(heroku config --remote production | tail -n +2 | sed "s/\:[[:blank:]]*\\(.*\\)/=\'\\1\'/g" | tr "\n" " ")' #"

alias localredis='REDIS_URL=redis://localhost:6379/0'
alias herokus='TERM=ansi heroku run -r staging -- bash'
alias herokup='TERM=ansi heroku run -r production -- bash'
alias herokuslog='heroku logs -t -r staging | tee staging.log'
alias herokuplog='heroku logs -t -r production | tee prod.log'
alias deploys='./script/deploy --stage=staging'
alias deploysm='./script/deploy --stage=staging --migrate'
alias deploys='./script/deploy --stage=production'
alias deploysm='./script/deploy --stage=production --migrate'
# emacs
alias emak='TERM=xterm-emacs emacs -nw'
alias emac='TERM=xterm-emacs-kitty emacs -nw'
alias ec='TERM=xterm-emacs-kitty emacsclient -nw'
alias ee='ec -e "(progn (+workspace:delete)(+workspace/switch-to-final))"'
function es() {
	emacsclient -n $@
}
function ek() {
	emacsclient -n $@ && ec $_
}
alias pke='pkill -i emacs'
alias zrc='$EDITOR ~/.zshrc'
alias prc='$EDITOR ~/.profile'
alias secret='$EDITOR ~/.secret'
alias krc='$EDITOR ~/.config/kitty/kitty.conf'
alias grc='$EDITOR ~/.gitconfig'
# used for emacsclient..i think? *doubt*
# export ALTERNATE_EDITOR=""
# export EDITOR="emacsclient -nw"                  # $EDITOR opens in terminal
export EDITOR="nvim" # $EDITOR opens in terminal
# used in emacs .config
alias jslsp='node ~/Code/Forks/javascript-typescript-langserver/lib/language-server-stdio'

# utility
alias py='python3'
alias lsbin='ls ~/.bin'
alias bin='cd ~/.bin'
function prcg() {
	# Stolen version does work
	more ~/.profile | grep -b1 -a4 $1
	# My version does not work
	# grep -A 4 -B 1 -- "$@" ~/.profile
}

# elixir
alias xie='rlwrap --always-readline iex -S mix'
alias iex='rlwrap --always-readline iex'
# miex: opens iex in context of project in directory
# (root directory of the project i think)
# persistent history for IEx
export ERL_AFLAGS="-kernel shell_history enabled"

### scripty

# go, for LSP
export PATH="$(go env GOPATH)/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init --path)"
fi

alias org='cd ~/Code/orgzly'
alias ngdav='ngrok http 80 -subdomain=orgzlying'
function npmdav() {
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
alias gha="act -P ubuntu-latest=catthehacker/ubuntu:js-latest-dev"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Per homebrew guile installation info:
export GUILE_LOAD_PATH="/opt/homebrew/share/guile/site/3.0"
export GUILE_LOAD_COMPILED_PATH="/opt/homebrew/lib/guile/3.0/site-ccache"
export GUILE_SYSTEM_EXTENSIONS_PATH="/opt/homebrew/lib/guile/3.0/extensions"

# always tmuxify my shell :)
# https://unix.stackexchange.com/a/113768/235506
if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
	exec tmux
fi
