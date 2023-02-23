#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Search for bash aliases file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

PS1='[\u@\h \W]\$ '

# VI [ESC] VIM [ESC + V]
set -o vi
export EDITOR="/usr/bin/vim"

