# comment out to avoid timer on first prompt:
# timer=$(gdate +%s%3N)
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile && source ~/.secret'

alias sorc='source ~/.zshrc'
autoload zmv

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo "linux detected"
  # LINUX configs
  export PATH="$(yarn global bin):$PATH"
elif [[ "$OSTYPE" == "darwin"* ]]; then

  # echo "MACOS detected"
  rpb(){ # copy path from file into clipboard
    realpath "$1" | pbcopy
  }
  #MACOS configs
  #postgres path
  export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
  #redis path
  export PATH="/Applications/Redis.app/Contents/Resources/Vendor/redis/bin:$PATH"
  # sclang path (supercollider through brew cas)
  export PATH="/Applications/SuperCollider.app/Contents/MacOS:$PATH"

  #NVM
  # old veresion of loading NVM is too slow (and the NVM_DIR doesn't make sense):
  # export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  # [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  # new version per https://github.com/nvm-sh/nvm/issues/1978
  if [ -s "$HOME/.nvm/nvm.sh" ]; then
  export NVM_DIR="$HOME/.nvm"
  nvm_cmds=(nvm node npm yarn)
  for cmd in $nvm_cmds ; do
    alias $cmd="unalias $nvm_cmds && unset nvm_cmds && . $NVM_DIR/nvm.sh && $cmd"
  done
  fi

  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


  # necessary for doom emacs to work with macports
  export PATH="/Applications/MacPorts/Emacs.app/Contents/MacOS:$PATH"
  # tell mac to shut its hole
  export BASH_SILENCE_DEPRECATION_WARNING=1
  export ASDF_DATA_DIR=`brew --prefix asdf`/
  source $ASDF_DATA_DIR/asdf.sh

  # GNU find
  # gnu coreutils from `brew install coreutils`
  export PATH="`brew --prefix`/opt/findutils/libexec/gnubin:$PATH"
  export MANPATH="`brew --prefix`/opt/coreutils/libexec/gnuman:${MANPATH}"
else
  echo "Unknown OS: $OSTYPE"
fi

if ! ps -e -o args | grep -i 'emacs' | grep -q 'daemon'; then
  echo "Emacs is loading"
  emacs --daemon
else
  # echo "Emacs server Online"
fi



# vim mode
# https://github.com/jeffreytse/zsh-vi-mode
source $HOME/.config/zsh/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

# https://github.com/jeffreytse/zsh-vi-mode/issues/79
# The plugin will auto execute this zvm_after_init function
function zvm_after_init() {
  zvm_bindkey viins 'jk' zvm_exit_insert_mode
  zvm_bindkey viins 'kj' zvm_exit_insert_mode
}

## oh-my-zsh config:

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=()

VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
#MODE_INDICATOR="%F{yellow}+%f"

source $ZSH/oh-my-zsh.sh

# Pure must be activated ~after~ `source $ZSH/oh-my-zsh.sh`
# fpath+=$HOME/Code/GitBuilds/pure
# autoload -U promptinit; promptinit
# prompt pure
# if Pure isn't installed, just add zsh theme such as "robbyrussel", comment above lines


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ➜
SUCCESS_COLOR_NORMAL="%{$fg_bold[cyan]%}"
SUCCESS_COLOR_INSERT="%{$fg_bold[green]%}"
SUCCESS_COLOR=$SUCCESS_COLOR_NORMAL
FAIL_COLOR_NORMAL="%{$fg_bold[yellow]%}"
FAIL_COLOR_INSERT="%{$fg_bold[red]%}"
FAIL_COLOR=$FAIL_COLOR_NORMAL
INSERT_SYMBOL="|>"
NORMAL_SYMBOL="<|"
PROMPT_SYMBOL=$NORMAL_SYMBOL
SUCCESS_PROMPT=$SUCCESS_COLOR$PROMPT_SYMBOL
FAIL_PROMPT=$FAIL_COLOR$PROMPT_SYMBOL

RPROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} %{$reset_color%}'

# The plugin will auto execute this zvm_after_select_vi_mode function
function zvm_after_select_vi_mode() {
  case $ZVM_MODE in
    $ZVM_MODE_NORMAL)
      PROMPT_SYMBOL=$NORMAL_SYMBOL
      FAIL_COLOR=$FAIL_COLOR_NORMAL
      SUCCESS_COLOR=$SUCCESS_COLOR_NORMAL
      prompt
      ;;
    $ZVM_MODE_INSERT)
      PROMPT_SYMBOL=$INSERT_SYMBOL
      FAIL_COLOR=$FAIL_COLOR_INSERT
      SUCCESS_COLOR=$SUCCESS_COLOR_INSERT
      prompt
    ;;
  esac
}

# sets the time to the left prompt only once
function prompt_date(){
  local date=`gdate +%-H:%M:%S`
  local color="{$fg_bold[blue]%}"
  DATE=$color$date
}

prompt_date

function prompt(){
  SUCCESS_PROMPT=$SUCCESS_COLOR$PROMPT_SYMBOL
  FAIL_PROMPT=$FAIL_COLOR$PROMPT_SYMBOL
  PROMPT="%$DATE %(?:$SUCCESS_PROMPT:$FAIL_PROMPT) %{$fg_no_bold[default]%}%"
}

prompt

# TODO:
# Remove OMZ

function preexec() {
  prompt_date
  timer=$(gdate +%s%3N)
}

function precmd() {
  if [ $timer ]; then
    local now=$(gdate +%s%3N)
    local d_ms=$(($now-$timer))
    local d_s=$((d_ms / 1000))
    local ms=$((d_ms % 1000))
    local s=$((d_s % 60))
    local m=$(((d_s / 60) % 60))
    local h=$((d_s / 3600))
    if ((h > 0)); then elapsed=${h}h${m}m
    elif ((m > 0)); then elapsed=${m}m${s}s
    elif ((s >= 10)); then elapsed=${s}.$((ms / 100))s
    elif ((s > 0)); then elapsed=${s}.$((ms / 10))s
    else elapsed=${ms}ms
    fi

    # Overrides the RPROMPT above
    RPROMPT=' %{$reset_color%}${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}${elapsed} %c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} %{$reset_color%}'
    unset timer
  fi
}


# TODO:
# some indicator of weeks in month and the day where month changes
# for example:
# month with 4 weeks, 1st falls on Mon and last day on Tue
# [ M X X T ]
function ddate(){
  DEF_COLOR="$fg_bold[black]"
  HI_COLOR="$fg_bold[white]"
  MED_COLOR="$fg_no_bold[blue]"

  months=(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)

  echo -n $DEF_COLOR
  current_month_number=`gdate +%-m`
  for ((i = 1; i <= $#months; i++)); do
    if [[ $current_month_number == $((i)) ]]
  then
    echo -n $HI_COLOR`gdate "+%h"`$DEF_COLOR
    else
      echo -n ${months[$i]}
    fi
    echo -n " "
  done
  echo

  # uncomment for testing
  days=(Sun Mon Tue Wed Thu Fri Sat)
  current_day_number=`gdate +%-d` # 1..31
  #current_day_number=1
  current_weekday=`gdate +%a` # Mon...Sun
  weekday_index=$((`gdate +%w`+1)) # 1...7 => Sunday is 1
  total_days_month=`gdate -d "-$(($current_day_number-1)) days +1 months -1 days" +%d` # 29,30,31
  #total_days_month=`gdate -d "-$(($(gdate +%-d)-1)) days +1 months -1 days" +%d` # 29,30,31
  for ((i = 1; i <= $#days; i++)); do
  day=$days[i]
  if [[ $current_weekday == $day ]]
  then
    local day=`echo $day | cut -c1`
    local print_day=$HI_COLOR$day$DEF_COLOR
  else
    local day=`echo $day | cut -c1`
    local print_day=$day
  fi
  echo -n "$print_day "
  local prev_month_change=$((i-weekday_index+current_day_number))
  if (( $prev_month_change == 0 ))
  then
    echo -n "$MED_COLOR|$DEF_COLOR "
  fi
  local next_month_change=$((prev_month_change-total_days_month))
  if (( $next_month_change == 0 ))
  then
    echo -n "$MED_COLOR|$DEF_COLOR "
  fi
  done

  echo  "$HI_COLOR$current_day_number$MED_COLOR/$total_days_month"
}
ddate

# Java?
# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"
