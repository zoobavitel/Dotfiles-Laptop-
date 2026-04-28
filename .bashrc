#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
eval "$(starship init bash)"
export PATH="$HOME/.local/bin:$PATH"
alias dot='git --git-dir=/home/z/git/Dotfiles-Laptop-/.git --work-tree=/home/z'
