
# MacPorts Installer addition on 2020-11-05_at_09:38:36: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

export PATH=~/.emacs.d/bin:$PATH
export PATH="~/.bin:$PATH"
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cfgsetup='cfg config status.showuntrackedfiles no'
alias g='git'
alias code='cd ~/Code'
alias notes='cd ~/Notes'
alias lang='cd ~/Language'
alias jslsp='node ~/Code/Forks/javascript-typescript-langserver/lib/language-server-stdio'
alias vimrc='vim ~/.vimrc'
alias vim='vim -S ~/.vimrc' # necessary only if using neovim, as neovim reads the config from somewhere else

alias emacs='TERM=xterm-emacs-kitty emacs -nw'

