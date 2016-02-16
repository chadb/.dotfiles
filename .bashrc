# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# vim:ts=4:sw=4

# If not running interactively, don't do anything
#[ -z "$PS1" ] && return

# for man pages in mac os x
if [ -d /usr/share/man ]; then
    MANPATH=/usr/share/man:$MANPATH
fi

# mysql
if [ -d /usr/local/mysql/bin ]; then
    PATH=/usr/local/mysql/bin:$PATH
    MANPATH=/usr/local/mysql/man:$MANPATH
fi

# cuda 
if [ -d /usr/local/mysql/bin ]; then
    PATH=/usr/local/cuda/bin:$PATH
    MANPATH=/usr/local/cuda/man:$MANPATH
fi

# php
if [ -d /usr/local/php/bin ]; then
    PATH=/usr/local/php/bin:$PATH
fi

# nodejs and package manager npm
if [ -d /usr/local/share/npm/bin ]; then
    PATH=/usr/local/share/npm/bin:$PATH
fi

# for fink in mac os x
if [ -f /sw/bin/init.sh ]; then
    source /sw/bin/init.sh
fi

# for ports in mac os x
if [ -d /opt/local/bin ]; then
    PATH=/opt/local/bin:/opt/local/sbin:$PATH
    MANPATH=/opt/local/man:/opt/local/share/man:$MANPATH
fi

if [ -d /opt/local/libexec/gnubin/ ]; then
    PATH=/opt/local/libexec/gnubin/:$PATH
    MANPATH=/opt/local/libexec/gnubin/man::$MANPATH
fi

# local sbin apps
if [ -d /usr/local/sbin ]; then
    PATH=/usr/local/sbin:$PATH
fi

if [ -d /usr/local/bin ]; then
    PATH=/usr/local/bin:$PATH
    MANPATH=/usr/local/man:/usr/local/share/man:$MANPATH
    LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
fi

if [ -d $HOME/bin ]; then
    PATH=$HOME/bin:$PATH
fi

if [ "$TERM" != "dumb" ]; then
    if [ `uname` == 'Darwin' ]; then 
        export LS_OPTIONS='-hG'
    else
        export LS_OPTIONS='-h --color=auto'
        eval `dircolors ~/.dir_colors`
    fi
fi

export PATH
export MANPATH

# Locale info

export LC_ALL=C
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"


if [ -s ~/.rvm/scripts/rvm ] ; then source ~/.rvm/scripts/rvm ; fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# vim plugin rubocop needs this to work in gvim 
export BASH_ENV=~/.bashrc
