[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo "linux detected"
  # LINUX configs
  export PATH="$(yarn global bin):$PATH"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo "MACOS detected"
  #MACOS configs
  #postgres path
  export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
  #redis path
  PATH="/Applications/Redis.app/Contents/Resources/Vendor/redis/bin:$PATH"
  #NVM
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  eval "nvm use --lts"
  # necessary for doom emacs to work with macports
  export PATH="/Applications/MacPorts/Emacs.app/Contents/MacOS:$PATH"
  # tell mac to shut its hole
  export BASH_SILENCE_DEPRECATION_WARNING=1
else
  echo "Unknown OS: $OSTYPE"
fi

source ~/.zshrc-omz
