# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# Radu's stuff
#   export PS1='\[\033[01;31m\]\u@\H\[\033[01;34m\] \w \$\[\033[00m\] '
#
# with title
#export PS1='\[\033[01;31m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] \[\033]0;\h \w\007\]'

#export PS1='\[\033[01;31m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
export PS1='\[\033[01;31m\]\u@\h\[\033[01;32m\]$(__git_ps1)\[\033[01;34m\] \w \$\[\033[00m\] '

if [ -z "$BASH_VERSION" ]; then
   # script doesn't work with /bin/sh
   return
fi


# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=800000

shopt -s histappend
set -o ignoreeof
# PROMPT_COMMAND="history -a; history -n"

bind '"\e[A":history-search-backward' 2>/dev/null
bind '"\e[B":history-search-forward' 2>/dev/null

if grep --help 2>&1 | grep -q color; then
    export GREP_OPTIONS='-a --color'
fi


# alias vim='vim -T linux'
# alias view='view -T linux'
alias view='vim -R -M'


# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto'
# eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

function xcopy() { command xclip -i "$@"; }
function xpaste() { command xclip -o "$@"; }
function xpaste2() { command echo; xclip -o; echo; echo "$@"; }
function grep() { command grep --color "$@"; }
function xfiglatex() { command xfig -specialtext -latexfonts -startlatexFont default "$@"; }
#alias xdvi() { command xdvi -geometry 1000x700+12+0 -s 5 -keep "$@"; }
# function vim() { command vim -T linux "$@"; }
# function latex() { command latex --interaction=nonstopmode "$@"; }

set -o ignoreeof
# bind '"[A":history-search-backward'
# bind '"[B":history-search-forward'
bind '"\e[A":history-search-backward' 2>/dev/null
bind '"\e[B":history-search-forward' 2>/dev/null

function title() { command echo -e "\033]0;$1\007"; }


# usage persistent_ssh <host> <session-name>
function persistent_ssh() {
   title "$2 ($1)"
   if [ "$2" = "list" ]; then
      ssh -t $1 "tmux list-sessions"
   else
      command autossh -M0 -t $1 "tmux attach -t $2 || tmux new-session -s $2"
   fi
}

function dev() { persistent_ssh rberinde@rberinde-linux $1; }
function dbc() { persistent_ssh rberinde@vmc-dbc301 $1; }
function padbc() { persistent_ssh rberinde@pa-dbc1109 $1; }

function devask() {
   ( ssh -x rberinde@rberinde-linux "tmux list-sessions" | sed 's/^/  /' >/tmp/sessions 2>/dev/null; echo -e "\033[s\n"; cat /tmp/sessions; echo -en "\033[u" ) &
   # ( dev list | sed 's/^/  /' >/tmp/sessions 2>/dev/null; echo ""; cat /tmp/sessions; echo ""; echo -n "Enter a session name: " ) 2>/dev/null &
   echo ""
   echo -n "Enter a session name: "
   read name
   dev $name
}

export PATH=$PATH:~/bin
alias gopath=". ~/bin/gopath.sh"

source ~/liquidprompt/liquidprompt

# Null command to reset any error code
:
if [ -z "$DISPLAY" ]; then
    export DISPLAY=10.0.2.2:0
fi
#export TERM=linux
