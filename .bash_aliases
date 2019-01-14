#-------------------------------------------------------------
# bash aliases
#-------------------------------------------------------------

alias df='df -kTh'
alias lr='ll -R'           #  Recursive ls.
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ... 
alias ..='cd ..'

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias ldlibpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias modulepath='echo -e ${MODULEPATH//:/\\n}'

# Git commands
alias s='git status'

# Search history by pressing up (backward) and down (forward) arrow
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
