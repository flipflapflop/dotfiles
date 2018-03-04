
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

export CC=gcc
export CXX=g++
export FC=gfortran

#-------------------------------------------------------------
# module
#-------------------------------------------------------------

case $HOSTNAME in
    johnconnor)
        source /usr/share/modules/init/bash
        ;;
    saint-exupery)
        source /usr/local/Modules/init/bash
        ;;
esac

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
        module load openmpi/1.10.2
        module load gnu/mkl/seq/11.2.0
        module load metis/4.0.3
        module load starpu/trunk-fxt
        module load parsec/master-trace
        module load hsl/latest
        # module load spral/trunk
        module load spral/master
        export STARPU_FXT_PREFIX=/home/flopez/traces/
        ;;

    johnconnor)
        module load hsl/latest
        module load lapack/3.6.0
        module load cuda/7.5
        module load hwloc/1.11.6
        module load metis/4.0.3
        module load mpi/local
        module load starpu/trunk-nogpu
        module load parsec/trunk
        module load spral/master
        ;;

    cn1g01.gpu.rl.ac.uk)
        module load automake/1.14.1
        module load autoconf/2.69
        module load gcc/5.3.0
        module load intel/mkl/11.2.0.090
# CUDA settings
        module load cuda/8.0.44
        export CUDADIR=$CUDA_HOME
        module load hwloc/gpu-1.11.4
        module load starpu/trunk-gpu
        module load magma/1.7.0
        module load metis/4.0.3
        module load hsl/latest
        module load spral/master-gnu-5.3.0
        module use --append /home/cseg/numanlys/modules
# OMP setting
        export OMP_PROC_BIND=true
        ;;

    cn202.scarf.rl.ac.uk | cn255.scarf.rl.ac.uk)
        export OMP_CANCELLATION=true
        export OMP_PROC_BIND=true
        export ACLOCAL_PATH=/usr/share/aclocal
        module load automake/1.14.1
        module load autoconf/2.69
        module load cmake/3.4.3
        module load gcc/6.1.0
        module load intel/mkl/11.3.1.150
        export LBLAS="-L$MKL_LIBS -lmkl_gf_lp64 -lmkl_core -lmkl_sequential -lpthread -lm"
        export LLAPACK="-L$MKL_LIBS -lmkl_gf_lp64 -lmkl_core -lmkl_sequential -lpthread -lm"
        module load hwloc/1.11.6
        # module load openmpi/1.10.2
        module load starpu/1.2.3
        module load parsec/master
        module load metis/4.0.3
        module load hsl/latest
        module load spral/master-gnu-6.1.0
        module use --append /home/cseg/numanlys/scarf523/modulefiles
        module use --append /home/cseg/numanlys/modules
        ;;
    scarf.rl.ac.uk)
        module use --append /home/cseg/numanlys/modules
        ;;
    phobos.icl.utk.edu)
        # Compiler
        ## gnu
        export CC=/opt/bin/gcc
        export CXX=/opt/bin/g++
        export FC=/opt/bin/gfortran
        # Metis
        export METISDIR=/home/flopez/metis-4.0.3
        # HSL packages
        export HSLPACKDIR=/home/flopez/hsl/packages
        # Intel MKL
        export MKLROOT=/opt/intel_mkl2017/mkl/
        # Intel libraries
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/intel/lib/intel64
        # SPRAL
        ## gnu
        export SPRALDIR=/home/flopez/builds/spral/gnu
        # Parsec
        ## gnu
        export PARSECSRCDIR=/home/flopez/parsec
        export PARSECDIR=/home/flopez/builds/parsec/master/gnu/
        export PARSECPP=$PARSECDIR/parsec/interfaces/ptg/ptg-compiler/parsec_ptgpp
        # LD Library Path
        export LD_LIBRARY_PATH=/lib64:$LD_LIBRARY_PATH
        export LD_LIBRARY_PATH=/opt/lib64:$LD_LIBRARY_PATH
        export LD_LIBRARY_PATH=/opt/lib:$LD_LIBRARY_PATH
        ;;
    dancer.icl.utk.edu | dancer*)
        export ACLOCAL_PATH=/usr/share/aclocal
        module load gcc/6.3.0
        ;;
    *.hpc2n.umu.se)
        module load GCC/6.4.0-2.28
        module load GCCcore/6.4.0
        module load binutils/2.28
        module load CMake/3.9.1
        module load hwloc/1.11.8
        module load gimkl/2017b
        export HSLDIR=/home/f/flopez/hsl2013
        export HSLPACKDIR=/home/f/flopez/hsl2013/packages
        # GNU Libtool
        export PATH=/home/f/flopez/builds/libtool/2.4.6:$PATH
        # Own module files
        module use /home/f/flopez/modulefiles
        module load metis/4.0.3
        module load scotch/6.0.4
        module load starpu/trunk
        module load spral/master-gnu-6.2.0
        ;;
    saint-exupery)
        module load fxt/0.3.7
        module load starpu/trunk
        module load spral/master-gcc-7.2.0
        module load mkl/2018.1.163
        module load metis/4.0.3
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

