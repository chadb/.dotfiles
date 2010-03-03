# ~/.bash_profile: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# vim:ts=4:sw=4

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# add some more dirs to search binaries for...

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

# for fink in mac os x
if [ -f /sw/bin/init.sh ]; then
    source /sw/bin/init.sh
fi

# for ports in mac os x
if [ -d /opt/local/bin ]; then
    PATH=/opt/local/bin:/opt/local/sbin:$PATH
    MANPATH=/opt/local/man:/opt/local/share/man:$MANPATH
fi

# local sbin apps
if [ -d /usr/local/sbin ]; then
    PATH=/usr/local/sbin:$PATH
fi

if [ -d /usr/local/bin ]; then
    PATH=/usr/local/bin:$PATH
    MANPATH=/usr/local/man:/usr/local/share/man:$MANPATH
fi

if [ -d $HOME/bin ]; then
    PATH=$HOME/bin:$PATH
fi

if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto'
    eval `dircolors ~/.dir_colors`
fi


# bash completion
 if [ -f /opt/local/etc/bash_completion ]; then
  . /opt/local/etc/bash_completion
fi


export PATH
export MANPATH

# Locale info

export LC_ALL=C
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"

###########################################
# fancy prompt with git branch
# from: http://pastie.org/pastes/165446
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function proml {
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  local      YELLOW="\[\033[1;33m\]"
  case $TERM in
    xterm*)
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac

PS1="${TITLEBAR}\
$BLUE[$RED\$(date +%H:%M)$BLUE]\
$BLUE[$RED\u@\h:$YELLOW\W$GREEN\$(parse_git_branch)$BLUE]\
$GREEN\$ "
PS2='> '
PS4='+ '
}
proml

## set variable identifying the chroot you work in (used in the prompt below)
#if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
#    debian_chroot=$(cat /etc/debian_chroot)
#fi
#
## set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#xterm-color)
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#    ;;
#*)
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#    ;;
#esac
#
## Comment in the above and uncomment this below for a color prompt
##PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#
## If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
#    ;;
#*)
#    ;;
#esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi


alias ls='\ls -hF $LS_OPTIONS'
alias ll='\ls -ahFl $LS_OPTIONS'
alias lsd='\ls -ahld $LS_OPTIONS * | egrep "^d"'
alias lsbymostrecent="ls -lhurtF"  
alias lsbysize="ls -luhrS"  
alias psg="ps -auxww | grep -i "
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias +='pushd .'
alias _='popd'
alias ss='script/server'
alias sc='script/console'
alias sg='script/generator'
alias sa='script/about'

#convenient sets because i'm lazy

bdd="beardendesigns.com"
gc="glenncertain.com"
rdi="riverdaleinn.com"
lmc="lmcoutcomes.lmcmc.com"
lmcdental="lmcdental.lmcmc.com"

export EDITOR=vim
export CVS_RSH=ssh


#enable vi command line editing
set -o vi
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Mac OS X specific
if [ `uname -s` = "Darwin" ] ; then
#    alias ls='\ls -FG'
#    alias ll='\ls -aFlG'
#    alias lsd='\ls -aldG * | egrep "^d"'
    alias gvim='~/bin/mvim'
fi

if [ -f /usr/local/jruby/bin/jruby ]; then
    export JRUBY_HOME=/usr/local/bin/jruby
    # share gem library with cruby and jruby
    #export GEM_HOME=/usr/local/lib/ruby/gems/1.8
    PATH=$PATH:/usr/local/jruby/bin
fi


if [ -s ~/.rvm/scripts/rvm ] ; then source ~/.rvm/scripts/rvm ; fi