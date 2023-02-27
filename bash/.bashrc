#
# ~/.bashrc
#

# Command History Config
shopt -s histappend
shopt -s cmdhist
shopt -s cdspell

HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:ll:la:l:lsd:[bf]g:exit:clear:history"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source aliases configuration file 
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# Vi command line [ESC], Vim command Editor [ESC+v]
set -o vi
export EDITOR="/usr/bin/vim"

# Package seggestion for not founded commands
source /usr/share/doc/pkgfile/command-not-found.bash
 
# Prompt configuration
STATUS="if [ \$? -ne 0 ]; then echo \"\e[1;31m\$\e[0m\"; else echo \"\e[1;32m\$\e[0m\"; fi"
PS1="\e[2;37m[\u@\h\e[0m \e[1;33m\W\e[0m \e[2;37m\$?]\e[0m\`${STATUS}\` "

up() { cd $(eval printf '../'%.0s {1..$1}); }
