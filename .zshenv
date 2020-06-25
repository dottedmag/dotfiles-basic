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
    __ap "$HOME/Library/Python/3.7/bin"
    __ap "$HOME/.cabal/bin"
    __ap "$HOME/Applications/ghc-7.10.3.app/Contents/bin"
    __ap "$HOME/.gem/ruby/2.3.0/bin"
    __ap "$HOME/.cargo/bin"
    __ap /Applications/Postgres.app/Contents/Versions/latest/bin
    __ap /usr/local/heroku/bin
    __ap $HOME/apps/go/bin
    __ap $HOME/go/bin

    if [ -d $HOME/go/bin ]; then
      export GOBIN=$HOME/go/bin
    fi

    __ap "$HOME/.perl5/bin"
    PERL5LIB="$HOME/.perl5/lib/perl5"
    PERL_LOCAL_LIB_ROOT="/Users/dottedmag/.perl5"
    PERL_MB_OPT="--install_base \"/Users/dottedmag/.perl5\""
    PERL_MM_OPT="INSTALL_BASE=/Users/dottedmag/.perl5"
    export PERL5LIB PERL_LOCAL_LIB_ROOT PERL_MB_OPT PERL_MM_OPT

    export PATH="$HOME/bin:$PATH"
    export _PATH_SET=1
fi
