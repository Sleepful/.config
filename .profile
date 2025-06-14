#https://superuser.com/questions/433746/is-there-a-fix-for-the-too-many-open-files-in-system-error-on-os-x-10-7-1
ulimit -S -n 40444
alias culprit="sudo lsof -n | cut -f1 -d' ' | uniq -c | sort | tail"

export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local/share
export FLAVOURS_DATA_DIRECTORY="$XDG_DATA_HOME/flavours"
export FLAVOURS_CONFIG_FILE="$XDG_CONFIG_HOME/flavours/config.toml"
# MacPorts Installer addition on 2020-11-05_at_09:38:36: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# nix installed bins
export PATH=~/.nix-profile/bin:$PATH

# aider.chat, installed through pip/python
export PATH=~/.local/share/../bin:$PATH

# static default port for Clojure nrepl with lein
export LEIN_REPL_PORT=1337
# start clojure repl wilh clj build tools, uses the :alias `repl/conjure` which ought to be found in user directory,
# per https://clojure.org/reference/clojure_cli#config_dir
# in theory, "~/.config/clojure/deps.edn"
alias repl="clj -M:repl/conjure -p 1337"

# Finished adapting your PATH environment variable for use with MacPorts.

export PATH="/opt/homebrew/bin:$PATH"
export PATH=~/.emacs.d/bin:$PATH
export PATH="$HOME/.bin:$PATH"
# rust cargo

# deno 
# export PATH="$HOME/.deno/bin:$PATH"
# export PATH="`asdf where deno`/.deno/bin:$PATH"

export TERM="xterm-kitty"

alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cfgsetup='cfg config status.showuntrackedfiles no'

alias sprc='source ~/.profile'
alias szrc='source ~/.zshrc'
alias ssecret='source ~/.secret'

export CLOUD=~/Documents/Cloud-Drive

source ~/.profile.subshell
alias prcs='vim ~/.profile.subshell'

alias k='kubectl'

alias pb='pbpaste'

# Begin CDs
alias home='cd ~/'
alias code='cd ~/Code'
alias apps='cd ~/Code/apps'
alias lx='cd ~/Code/Lexical'
alias notif='cd ~/Code/notifs'
alias wb='cd ~/Code/WordDatabase/phx'
alias nt='cd ~/Code/Notateca'
alias conf='cd ~/.config'
alias notes='cd ~/Notes'
alias lang='cd ~/Language'
alias vimconf='cd ~/.config/nvim'
alias vimlibs='cd ~/.local/share/nvim/lazy'
alias important='cd ~/Important'
alias txt='cd ~/Important/Txt'
alias cloud='cd $CLOUD'
alias park='cd $PARK'
alias st='cd ~/Sync'

# Build dirs
alias kdir='cd ~/Code/GitBuilds/kitty'
alias gbs='cd ~/Code/GitBuilds'

# end of CDs

# neovim
export PATH="$HOME/local/nvim/bin:$PATH"
alias vim='nvim'
alias vih='nvim .'
alias vrc='nvim ~/.vimrc'
alias vimf='vim $(`fc -ln -1`)'
alias vimr='vim README.md'

# golang alias
alias gog='go run main.go'

# tmux
function cd {
	builtin cd "$@" && tmux renamew $(basename `pwd` | cut -c1-5)
}
alias tm='tmux'
alias tmrc='vim ~/.tmux.conf'

tmux-join() {
	if pgrep tmux; then
		# join tmux existing session
		new_session=`tmux ls | sort | awk '{print $1}' | tr -d ':' | xargs shuf -n1 -e`
		tmux attach -t $new_session
	else
		# begin new session
		tmux new-session -s hi
	fi
}

jump() {
	# switch session and kill previous one
	session_to_discard=tmux display -p '#S'
	echo $session_to_discard
	tm detach -E "tmux attach -t $1"
	tm kill-session -t $session_to_discard
}

clean() {
	# switch session and kill previous one
	session_to_discard=tmux display -p '#S'
	new_session=tm list-windows -F '#{window_index}' -f '#{!=:#{window_index},#{active_window_index}}' | xargs shuf -n1 -e
	tm detach -E "tmux attach -t $new_session"
	tm kill-session -t $session_to_discard
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

# git, as function to export to subshells
function g() {
	git "$@"
}

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
alias clearpgpid='pkill postgres && rm ~/Library/Application\ Support/Postgres/var-14/postmaster.pid'
# Npm/Yarn MACOS stuff
alias fixgyp="sudo rm -r -f $(xcode-select --print-path) \
  && xcode-select --install"

alias psf='ps aux | grep -i'
# others
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
alias girc='$EDITOR ~/.gitconfig'
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
# xie: opens iex in context of project in directory
# (root directory of the project i think)
alias xie='iex -S mix'
# rlwrap necessary for kitty, but not for tmux
# alias iex='rlwrap --always-readline iex'

# ERL_AFLAGS: persistent history for IEx between sessions
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

alias clearndocker='docker system prune -a'
alias tunnel='frpc -c ~/.config/frp/frpc.toml'
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

# flavours
alias flavour="flavours --config ~/.config/flavours/config.toml apply "
alias fl="flavour && flavours current"
# E.g:
# fl nord
# fl tango
alias theme='flavour `flavours list | sed "s/ /\n/g" | sed "/^$/d" | fzf`'

alias dir='cd `fd -t d | fzf || echo .`'
# alias undir for traveling up?

# fzf
export FZF_DEFAULT_OPTS='--height 60% --min-height 12 --reverse --border --multi --tiebreak="length,end" --info=inline --pointer="->" --marker="<>" --tabstop=2
--color bg+:0,hl:2,hl+:2,prompt:6,pointer:6,fg+:6,marker:6,info:3,info:bold,hl+:underline,fg+:underline,hl:italic,spinner:2
--bind="ctrl-u:half-page-up,ctrl-d:half-page-down,change:first,ctrl-w:backward-kill-word,ctrl-b:backward-word,alt-bs:clear-query,ctrl-l:forward-char,ctrl-h:backward-char,ctrl-f:forward-word,alt-j:preview-down,alt-k:preview-up,alt-u:preview-half-page-up,alt-d:preview-half-page-down,ctrl-y:execute-silent(echo {} | xclip -sel clip)"'

alias branch='git checkout `git branch | gsed "s/\* /\*/g"|  xargs -n1 echo  | sort | gsed "s/\*//g" | fzf`'
alias quicksave='git --no-pager diff > ~/Documents/Cloud-Drive/work.diff'

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Per homebrew guile installation info:
export GUILE_LOAD_PATH="/opt/homebrew/share/guile/site/3.0"
export GUILE_LOAD_COMPILED_PATH="/opt/homebrew/lib/guile/3.0/site-ccache"
export GUILE_SYSTEM_EXTENSIONS_PATH="/opt/homebrew/lib/guile/3.0/extensions"

# always tmuxify my shell :)
# https://unix.stackexchange.com/a/113768/235506
if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
       # `exec` with `export`, otherwise exec fails and terminal exits as soon as it opens
       # https://unix.stackexchange.com/questions/50692/executing-user-defined-function-in-a-#find-exec-call
	exec bash -c $(
		$(export -f tmux-join)
	)
fi

# cannot call GH from non-iteractive shell such as neovim cmd
# exits with 128, probably due to auth
alias ghpr='gh pr view --web || gh pr create --web'

# lvl 2 is a subshell when using an interactive zsh shell inside tmux
# -gt is greater_than
# so the fnuction is exported only when the SHLVL is greater than 2
if [[ $SHLVL -gt '2' ]]; then
	export -f g
	export -f jump
fi

# fh - repeat history
fh() {
	print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
	local pid
	if [ "$UID" != "0" ]; then
		pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
	else
		pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
	fi

	if [ "x$pid" != "x" ]; then
		echo $pid | xargs kill -${1:-9}
	fi
}
. "$HOME/.cargo/env"

# dotnet stuff START
# installing this for the LSP mainly, but might work for local dev too
# The .NET tools collect usage data in order to help us improve your experience
# set to 1 to remove telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1 
export PATH=$PATH:~/.dotnet/tools
# dotnet runtime:
export DOTNET_ROOT=~/.asdf/installs/dotnet-core/7.0.404 # maybe not necsesary? IDK
# `asdf plugin-add dotnet-core https://github.com/emersonsoares/asdf-dotnet-core.git`
# `dotnet tool install --global csharp-ls`
# funny thing but for `cls-sharp` I needed this version: 
# `asdf install dotnet-core 7.0.404`
# dotnet stuff END

