# -*- mode:sh -*-

# Tools

if [ -f /etc/debian_version -o -f /etc/ubuntu_version ]; then
    # Optimized common case
    alias grep='grep --color=auto'
    export GZIP='--rsyncable'
    eval $(lessfile)
    PROMPT_COLOR=green
elif [ -d /System ]; then
    # Another optimized common case
    alias grep='grep --color=auto'

    if [ $TERM = rxvt-unicode ]; then
        export TERM=rxvt
    fi

    if [ $TERM = rxvt-256color ]; then
        export TERM=rxvt
    fi
    PROMPT_COLOR=blue
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
    PROMPT_COLOR=red
fi

if command -v colordiff >/dev/null; then
    alias diff=colordiff
fi

export LESS=-dFinQRXS

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
zstyle ':vcs_info:cvs:*' formats ' (%s)%c-'
zstyle ':vcs_info:cvs:*' actionformats ' (%s)-[%a]%c-'

PS1='[%n@%m:%~]%70(l|
|)%# '

if [ $TERM = screen.rxvt ]; then
    export TERM=rxvt-unicode
fi

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
compinit -u

for i in ~/.zsh/functions/*.sh; do
  . $i
done

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/).svn'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#.svn'

function set_smart_prompt() {
  WHO_WHERE="[%F{$PROMPT_COLOR}%n@%m%f:%~]"
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
        set_smart_prompt;;
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
