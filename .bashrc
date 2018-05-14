# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "`dircolors`"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'


# esse faz o ls ficar colorido e com classificação de por / qndo for dir
alias ls="ls --color=tty --classify"
alias d="ls --color=tty --classify"
# esse faz o v virar um -l
alias v="d --format=long -h"
# faz o c ser um alias pra clear
alias c="clear"
# faz o df e o du sempre exibirem human readable
alias df="df -h"
alias du="du -h"
# pra ter mais cores no tmux
alias tmux="tmux -2"


# avoid hitting backspace and having ^H chars
#stty erase ^H

# editor for commits
export EDITOR='/usr/bin/vim'
export GIT_EDITOR=$EDITOR

# reopen last screen session. If not existing, open a new one
#if [[ $(ps aux | grep SCREEN | wc -l) -ge 2 ]] ; then
#    # there is at least one running screen process, let's try to attach to it
#    screen -r
#    #if [ $? -eq 1 ]; then
#    #    # already attached. Open no screen on this case
#    #    screen
#    #fi
#fi

# Use bash completion to complete command args (e.g: git subcommands)
BASH_COMPLETION='/etc/bash_completion'
[ -e $BASH_COMPLETION ] && source $BASH_COMPLETION

export PATH="$PATH:$HOME/bin:$HOME/go/bin"
#export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda-7.5/lib64"


# working faster with git
alias gl="git log"
alias glp="git log -p"
alias gln="git log --name-only"
alias ga="git add -p"
alias gb="git branch"
alias gck="git checkout"
alias gdi="git diff"
alias gci="git commit"
alias gcia='git commit --amend --date="$(date -R)"'
alias gst="git status"

# working faster with Mercurial
alias hl="hg log --graph"
alias hci="hg commit"
alias gcia='git commit --amend --date="$(date -R)"'
alias hlp="hg log --graph -p"
alias hli="hg log --graph --style compact"
alias hdi="hg diff"
alias hst="hg summary"

green='\033[1;32m'
blue='\033[1;34m'
NC='\033[0m'
export PS1='[${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;90m\]\D{%a} \t\[\033[00m\] :\[\033[01;34m\]\w\[\033[00m\]]\[\033[36m\]`__git_ps1`\[\033[0m\]$ '

#alias make="make -j10"
#alias make="make JOBS=10"

# Avoid CTRL+S accidently freezing your shell
stty -ixon

HISTSIZE=10000

function rmd() {
  pandoc $1 | lynx -stdin
}
