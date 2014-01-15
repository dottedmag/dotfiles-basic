# -*- mode: sh -*-

if [ -f /mach_kernel ]; then
  # OS X >= 10.6 sets LC_CTYPE to "UTF-8"
  export LC_ALL=en_US.UTF-8
fi

if [ -f /mach_kernel ]; then
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH
fi

export PATH=$HOME/bin:$HOME/.cabal/bin:$PATH:/sbin:/usr/sbin

if [ -d $HOME/.gem/ruby/2.0.0/bin ]; then
    export PATH=$PATH:$HOME/.gem/ruby/2.0.0/bin
fi
