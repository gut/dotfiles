# ~/.bashrc: executed by bash(1) for non-login shells.

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi


eval $(dircolors ~/.dir_colors)

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
# abrir sessão, se já existente
alias mytmux='[[ $(tmux list-sessions) ]] && tmux attach || tmux'


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
alias gdic="git diff --cached"
alias gci="git commit"
alias gcia='git commit --amend --date="$(date -R)"'
alias gst="git status"
alias gf="git fetch"
# git open modified
alias gom='vim -p $(git diff --name-only)'
# git open cached modified
alias gocm='vim -p $(git diff --name-only --cached)'
# git open last commit
alias golc='vim -p $(git log -1 --name-only --format=)'

alias difflines="diff --unchanged-group-format='' --old-line-format='-%L' --new-line-format='+%L'"

source ~/bin/git-prompt.sh
source ~/bin/git-completion.bash
#export PS1='[${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\[\033[01;91m\]\h\[\033[00m\] \[\033[01;93m\]\D{%a} \t\[\033[00m\] :\[\033[01;34m\]\w\[\033[00m\]]\[\033[36m\]`__git_ps1`\[\033[0m\]$ '
export PS1='
\[\033[01;93m\]\D{%a} \t\[\033[00m\] \[\033[01;4m\]<$?>\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]\[\033[36m\]`__git_ps1`\[\033[0m\]
${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\[\033[01;95m\]\h\[\033[00m\] $ '


# Avoid CTRL+S accidently freezing your shell
#stty -ixon

HISTSIZE=100000

function rmd() {
  pandoc $1 | lynx -stdin
}

# grep -r for searching things in the project but skipping build and .git directory
function gr() {
    grep -nr --exclude=.coverage --exclude=cscope.* --exclude-dir=build --exclude-dir=.git "$*" .
}
