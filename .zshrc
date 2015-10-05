# -*- mode:sh -*-

# Tools

if [ -f /etc/debian_version -o -f /etc/ubuntu_version \
        -o -f /etc/altlinux-release ]; then
    # Optimized common case
    alias grep='grep --color=auto'
    export GZIP='--rsyncable'
    eval $(lessfile)
elif [ -f /System ]; then
    # Another optimized common case
    alias grep='grep --color=auto'

    if [ $TERM = rxvt-unicode ]; then
        export TERM=rxvt
    fi

    if [ $TERM = rxvt-256color ]; then
        export TERM=rxvt
    fi

else
    if [ $TERM = rxvt-256color ]; then
        export TERM=rxvt
    fi

    if grep 2>&1 --version | grep GNU >/dev/null; then
        alias grep='grep --color=auto'
    fi

    if gzip 2>&1 --help | grep --directories=skip rsyncable >/dev/null; then
        export GZIP='--rsyncable'
    fi

    if [ -f /usr/bin/lessfile ]; then
        eval $(lessfile)
    fi
fi

if ls --version / 2>/dev/null | grep Stallman >/dev/null; then
  alias ls="ls --color=auto -phs"
elif ls -FG / >/dev/null 2>&1; then
  alias ls="ls -FG"
else
  alias ls="ls -phs"
fi

export LESS=-IRS

export PYTHONSTARTUP=$HOME/.pythonrc.py

alias c=cd

alias gdb='gdb -q'

export DEBEMAIL=dottedmag@debian.org
export DEBFULLNAME="Mikhail Gusarov"
export EMAIL="Mikhail Gusarov <dottedmag@dottedmag.net>"

if [ -e $HOME/bin/e ]; then
    export EDITOR=e
elif [ -e /usr/bin/nano ]; then
    export EDITOR=nano
fi

# Zsh

HISTFILE=$HOME/.zhist
export HISTSIZE=1000000
export SAVEHIST=1000000

autoload -Uz vcs_info
zstyle ':vcs_info:*' disable bzr

PS1='[%n@%m:%~]%70(l|
|)%# '

if [ $TERM = screen.rxvt ]; then
    export TERM=rxvt-unicode
fi

function set_prompt() {
  WHO_WHERE="[%F{green}%n@%m%f:%~]"
  EXITCODE="%(?..%B%?%b)"
  NL_IF_LONG="%70(l|
|)"
  VCINFO="%(1v.%F{blue}%1v%f.)"
  PROMPTSIGN="%B%#%b"
  export PROMPT="${WHO_WHERE}${EXITCODE}${NL_IF_LONG}${VCINFO}${PROMPTSIGN} "
}

case $TERM in
    dumb)
        export PROMPT="%#"
        ;;
    *)
        set_prompt;;
esac

case $TERM in
    xterm*|rxvt*)
        function preexec {
          local s=${2//\\/\\\\};
          print -nP "\033]2;[zsh@%m:%~]%# $s\007\033]1;[%m:%~]%# $s\007"
        }

        function precmd {
          print -nP "\033]2;[zsh@%m:%~]%#\007\033]1;[%m:%~]%#\007"
          psvar=()
          vcs_info
          [[ -n $vcs_info_msg_0_ ]] && psvar[1]="$vcs_info_msg_0_"
        }
        ;;
esac

slashre=/; export WORDCHARS=${WORDCHARS/$slashre}

setopt no_auto_menu
setopt auto_pushd
setopt extended_glob
setopt share_history
setopt hist_ignore_all_dups
setopt hist_no_store
setopt hist_reduce_blanks
setopt inc_append_history
setopt extended_history
setopt pushd_ignore_dups
setopt no_bang_hist
setopt nobeep
setopt hist_ignore_space

fpath=(~/.zsh/completion $fpath)
autoload -U compinit
compinit

for i in ~/.zsh/functions/*.sh; do
  . $i
done

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/).svn'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#.svn'

