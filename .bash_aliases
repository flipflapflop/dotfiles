#-------------------------------------------------------------
# bash aliases
#-------------------------------------------------------------

alias df='df -kTh'
alias lr='ll -R'           #  Recursive ls.
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ... 

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias modulepath='echo -e ${MODULEPATH//:/\\n}'
