export EDITOR=emacs

# svn editor
export SVN_EDITOR="emacs"
export GIT_EDITOR="emacs"

# Normal Colors                                                                                  
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\[\033[0;32m\]'  # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\[\033[0;37m\]'  # White                                                                                     
                                                                  
# Bold
BBlack='\e[1;30m'       # Black
BRed='\[\033[1;31m\]'   # Red
BGreen='\[\033[1;32m\]' # Green
BYellow='\e[1;33m'      # Yellow
#BBlue='\e[1;34m'       # Blue
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White
BGrey='\[\033[1;30m\]'       # White
                                                                                                 
# Background                                                                                     
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White
                                                                                                 
NC='\[\033[0m\]'               # Color Reset

#-------------------------------------------------------------
# prompt
#-------------------------------------------------------------

used()                                                                                           
{
    echo $(ps -eo pcpu,user| sort -r -k1 | awk 'NR==2{if ($1 >= 90) print "1"; else print "0"}')
}

if [ "$TERM" != "dumb" ]                                                                         
then                                                                                             
                                                                                                 
    export PS1="${BGrey}[${NC}\$(if [[ \$(used) -eq 1 ]]; then echo \"${BRed}\"; else echo \"${BGreen}\"; fi)\H${BGrey}][${NC}${BGreen}\w${NC}${BGrey}]\n${NC}${BGrey}[${NC}${BGreen}\$${NC}${BGrey}] ${NC}"                                                
else
    export PS1="$ "
fi

#-------------------------------------------------------------
# module
#-------------------------------------------------------------

# add local modulefile directory
module load use.own

case $HOSTNAME in
    gauss)
        # add global modulefile directory
        module use --append /numerical/flopez/modulefiles
        # load default modules
        module load gnu/comp/default
        module load hwloc/1.11.2
        module load fxt/0.3.1
        module load gnu/mkl/seq/11.2.0
        module load metis/4.0.3
        module load hsl/latest
        module load starpu/trunk
        module load spral/trunk
        export STARPU_FXT_PREFIX=/home/flopez/traces/
        ;;
    johnconnor)
        module load hsl/latest
        module load lapack/3.6.0
        ;;
    cn1g01.gpu.rl.ac.uk)
        module load automake/1.14.1
        module load autoconf/2.69
        module load intel/mkl/11.3.1.150
        module load cuda/7.5.18
        export CUDADIR=$CUDA_HOME
        module load starpu/trunk
        module load magma/1.7.0
         module load spral/trunk
        ;;
    cn202.scarf.rl.ac.uk | cn255.scarf.rl.ac.uk)
        module load automake/1.14.1
        module load autoconf/2.69
        module load gcc/5.3.0
        module load intel/mkl/11.3.1.150
        export LBLAS="-L$MKL_LIBS -lmkl_gf_lp64 -lmkl_core -lmkl_sequential -lpthread -lm"
        export LLAPACK="-L$MKL_LIBS -lmkl_gf_lp64 -lmkl_core -lmkl_sequential -lpthread -lm"
        module load hwloc/1.11.2
        module load starpu/trunk-nogpu
        module load metis/4.0.3
        module load hsl/latest
        module load spral/trunk
        ;;
esac

#-------------------------------------------------------------
# alias
#-------------------------------------------------------------

source $HOME/.bash_aliases

#-------------------------------------------------------------
# Handy functions
#-------------------------------------------------------------

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'"$*"'*' -ls ; }

function extract()      # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}

