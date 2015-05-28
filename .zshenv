# -*- mode: sh -*-

# OS X >= 10.6 sets LC_CTYPE to "UTF-8"
if [ "$LC_CTYPE" = "UTF-8" ]; then
  unset LC_CTYPE
  export LC_ALL=en_US.UTF-8
fi

if [[ -z "$_PATH_SET" ]]; then
    P="$HOME/Library/Python/2.7"
    if [ -d "$P" ]; then
        export PATH="$P/bin:$PATH"
    fi

    if [ -d /opt/local/var/macports ]; then
        O=/opt/local
        export PATH="$O/bin:$O/sbin:$PATH"
    fi

    G="$HOME/Applications/ghc-7.10.1.app"
    if [ -d "$G" ]; then
        export PATH="$G/.cabal/bin:$G/Contents/bin:$PATH"
    fi

    R="$HOME/.gem/ruby/2.0.0/bin"
    if [ -d "$R" ]; then
        export PATH="$PATH:$R"
    fi

    P=/Applications/Postgres.app/Contents/Versions/9.4/bin
    if [ -d "$P" ]; then
        export PATH="$PATH:$P"
    fi

    H=/usr/local/heroku/bin
    if [ -d "$H" ]; then
        export PATH="$PATH:$H"
    fi

    export PATH="$HOME/bin:$PATH:/usr/sbin:/sbin"
    export _PATH_SET=1
fi
