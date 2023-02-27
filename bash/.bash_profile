# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source aliases configuration file 
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# History configurations
shopt -s histappend
HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:ll:la:l:lsd:[bf]g:exit:clear:history"

# More bash optional configurations
shopt -s cmdhist
shopt -s cdspell
shopt -s checkwinsize
set -o noclobber            # if you need, use this: >| filename
unset safe_term match_lhs

# Bash auto-completion
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Vi command line [ESC], Vim command Editor [ESC+v]
set -o vi
export EDITOR="/usr/bin/vim"

# Package seggestion for not founded commands
[ -r /usr/share/doc/pkgfile/command-not-found.bash ] && . /usr/share/doc/pkgfile/command-not-found.bash 

# change to parents, ex: 'up 2'
up() { cd $(eval printf '../'%.0s {1..$1}); }

# Colors for prompt
CYANO="\[$(tput setaf 6)\]"
GRAY="\[$(tput setaf 7)\]"
RESET="\[$(tput sgr0)\]"

# Prompt configuration
PS1="[\u@\h ${GRAY}\W${RESET} \$?]${CYANO}\$${RESET} "
PS2="> "
PS3="> "
PS4="+ "

