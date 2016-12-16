# -*- mode: sh -*-

# OS X >= 10.6 sets LC_CTYPE to "UTF-8"
if [ "$LC_CTYPE" = "UTF-8" ]; then
  unset LC_CTYPE
  export LC_ALL=en_US.UTF-8
fi

__ap() {
  if [ -d "$1" ]; then
      PATH="$1:$PATH"
  fi
}

if [[ -z "$_PATH_SET" ]]; then
    __ap "$HOME/Library/Python/3.5/bin"
    __ap "$HOME/.cabal/bin"
    __ap "$HOME/Applications/ghc-7.10.3.app/Contents/bin"
    __ap "$HOME/.gem/ruby/2.0.0/bin"
    __ap /Applications/Postgres.app/Contents/Versions/latest/bin
    __ap /usr/local/heroku/bin
    __ap $HOME/g/bin

    export PATH="$HOME/bin:$PATH"
    export _PATH_SET=1
fi
