# -*- mode: sh -*-

if [ $(uname -s) = Darwin ]; then
  export PATH=$HOME/bin:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin:$PATH:/sbin:/usr/sbin
  # OS X >= 10.6 sets LC_CTYPE to "UTF-8"
  export LC_ALL=en_US.UTF-8
else
  export PATH=$HOME/bin:$PATH:/sbin:/usr/sbin
fi

if [ -d $HOME/.gem/ruby/2.0.0/bin ]; then
    export PATH=$PATH:$HOME/.gem/ruby/2.0.0/bin
fi

HISTFILE=$HOME/.zhist
export HISTSIZE=1000000
export SAVEHIST=1000000

# export MANSECT=1:n:l:8:3:2:3posix:3pm:3perl:5:4:9:6:7:3tcl

export DEBEMAIL=dottedmag@debian.org
export DEBFULLNAME="Mikhail Gusarov"
export EMAIL="Mikhail Gusarov <dottedmag@dottedmag.net>"

if [ -e $HOME/bin/matee ]; then
	export EDITOR=matee
elif [ -e $HOME/bin/e ]; then
    export EDITOR=e
elif [ -e /usr/bin/nano ]; then
    export EDITOR=nano
fi

# ack(1)
export ACK_PAGER=less
