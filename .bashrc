if [ -f .bash_setup_env ]; then
    . .bash_setup_env
fi

#-------------------------------------------------------------
# spack
#-------------------------------------------------------------

export SPACK_LOADED=0

if [ -f ${SPACK_DIR}/share/spack/setup-env.sh ]; then
    # SPACK_STATUS=0
    . ${SPACK_DIR}/share/spack/setup-env.sh &> /dev/null
    if command -v spack  &> /dev/null
    then
        spack help &> /dev/null
        SPACK_SETUP_ENV_STATUS=$?

        if [ $SPACK_SETUP_ENV_STATUS -eq 0 ]
        then
            export SPACK_LOADED=1
        else
            export SPACK_LOADED=0
        fi
    fi    
    
    if [ $SPACK_LOADED -eq 0 ]
    then
        echo "Error detected while loading Spack"
    fi
    
fi
#. ~/spack/share/spack/setup-env.sh

#. $(~/spack/bin/spack location -i lmod)/lmod/lmod/init/bash
#. ~/spack/share/spack/setup-env.sh

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
# OpenMP
#-------------------------------------------------------------

# export OMP_NESTED=true
# export OMP_CANCELLATION=true
export OMP_PROC_BIND=true

# add local modulefile directory
#module use --append $HOME/privatemodules

case $HOSTNAME in

    *.hpc2n.umu.se)
        export OMP_CANCELLATION=true
        export OMP_PROC_BIND=true
        export LD_LIBRARY_PATH=/home/f/flopez/pfs/gtg-0.2-2/src/.libs/:$LD_LIBRARY_PATH
        module load GCC/7.3.0-2.30
        # module load GCC/8.2.0-2.31.1
        module load CMake
        module load hwloc/1.11.10-gpu
        module load CUDA
        export HWLOCDIR=$EBROOTHWLOC
        export HSLDIR=/home/f/flopez/hsl2013
        export HSLPACKDIR=/home/f/flopez/hsl2013/packages
        # GNU Libtool
        export PATH=/home/f/flopez/builds/libtool/2.4.6:$PATH
        # Own module files
        module use /home/f/flopez/modulefiles
        module load mkl/2017
        module load metis/4.0.3
        # module load scotch/6.0.4
        module load starpu/master-gpu-openmp
        module load spral/gpufix-gcc-7.3.0-gpu-openmp
        ;;

    saint-exupery)
        module load hwloc/1.11.11
        module load fxt/0.3.7
        module load starpu/master
        module load spral/master-gnu-7.3.0
        module load mkl/2018.1.163
        module load metis/4.0.3
        ;;

    *.alembert|saturn.icl.utk.edu)
        module purge # clean loaded modules
        export MODULEPATH=$MODULEPATH:/home/flopez/spack/share/spack/modules/linux-scientific7-nehalem/    
        module load cmake/3.16.2
        module use --append $HOME/privatemodules
        # Load CUDA 10
        #module load cuda/10.0.130
        module load cuda/10.1/gcc-7.3.0-l7ex
        export CUDA_HOME=$CUDADIR
        # export OMP_PLACES=cores
        export OMP_PLACES="{0:20},{10:20}"
        export LD_LIBRARY_PATH=/home/flopez/gtg-0.2-2/src/.libs/:$LD_LIBRARY_PATH
        export OMP_NUM_THREADS=20
        module load fxt/0.3.7
        module load hwloc/1.11.10-gpu
        # module load starpu/master-gpu
        module load starpu/master-gpu-openmp
        export STARPU_PREFETCH=1
        export STARPU_MALLOC_PINNED=0
        module load metis/4.0.3
        # module load intel-mkl/2017.4.239
        module load intel-mkl/2019.3.199/gcc-7.3.0-2pn4
        module load spral/gpufix-gcc-7.3.0-gpu-openmp
        module load cutlass/master
        module load gcc/7.3.0
        module load magma/2.5.2
        module load cudnn/10.0
        module load mpi/openmpi/3.0.0
        module load parsec/master-debug
        ;;

    pge*|hcplogin2)
        module load use.paragon
        export ACLOCAL_PATH=/usr/share/aclocal/
        export autom4te_perllibdir=/gpfs/paragon/local/apps/gcc/utilities/share/autoconf
        export OMP_PLACES=cores
        export LD_LIBRARY_PATH=/gpfs/paragon/local/HCRI016/dre03/fxl09-dre03/gtg-0.2-2/src/.libs/:$LD_LIBRARY_PATH
        module load gcc6
        module load cuda/9.2
        module load xlf
        module load ibmessl/5.4
        export LBLAS="-L${ESSL_LIB} -lessl -lxlf90_r -lxlfmath -lxl"
        export LLAPACK="-L${ESSL_LIB} -lessl -lxlf90_r -lxlfmath -lxl"
        module use /gpfs/paragon/local/HCRI016/dre03/fxl09-dre03/privatemodules
        module load hwloc/1.11.12
        module load spral/gpufix
        module load cmake/3.10.2
        ;;

    evans)
        export MODULEPATH=$MODULEPATH:/home/flopez/spack/share/spack/modules/linux-ubuntu19.10-skylake
        module load cmake-3.17.0-gcc-9.2.1-yheryxd
        module load mkl/2020.0.166
        module load libpciaccess-0.13.5-gcc-9.2.1-g6amv64
        # module load xz-5.2.5-gcc-9.2.1-vh77osg
        module load hwloc-1.11.11-gcc-9.2.1-z4prrl2
        module load openmpi-4.0.3-gcc-9.2.1-3i4pipm
        module load parsec-mermoz/master-debug
        module load starpu/1.3.3
        module load magma/2.5.2
        source /opt/intel/oneapi/setvars.sh --force > /dev/null
        ;;
    
    leconte.icl.utk.edu)
        export ACLOCAL_PATH=$ACLOCAL_PATH:/usr/share/aclocal
        export MODULEPATH=$MODULEPATH:/nfs/apps/spack/share/spack/modules/linux-centos7-broadwell
        # Private spack modules
        export MODULEPATH=$MODULEPATH:/home/flopez/spack/share/spack/modules/linux-centos7-broadwell/
        export MODULEPATH=$MODULEPATH:/home/flopez/spack/share/spack/modules/linux-centos7-haswell/
        export MODULEPATH=$MODULEPATH:/home/scayrols/Modules/modulefiles/
        module load autoconf-2.69-gcc-4.8.5-gl2uqxy
        module load automake-1.16.2-gcc-4.8.5-f4d6ia2
        module load pkgconf-1.6.3-gcc-4.8.5-2qrpgpd
        module load gcc-8.4.0-gcc-4.8.5-uzcltsa   
        module load cmake-3.19.2-gcc-8.4.0-7gc5f6y
        module load intel-mkl-2020.4.304-gcc-8.4.0-knoj3qf
        module load magma/2.5.2
        module load htop-2.2.0-gcc-8.4.0-cuv3mq6
        module load openmpi/4.0.2/gcc-8.4.0_cuda-10.2
        module load parsec-mermoz/master
        
        module load zlib-1.2.11-gcc-8.4.0-j4klyoy
        module load opencv-4.2.0-gcc-8.4.0-2nahron

        export OMP_PLACES=cores
        ;;

    tellico*)
        export ACLOCAL_PATH=/usr/share/aclocal/:$ACLOCAL_PATH
        export MODULEPATH=$MODULEPATH:/apps/spack/share/spack/modules/linux-rhel7-power8le/
        export MODULEPATH=$MODULEPATH:/home/flopez/spack/share/spack/modules/linux-rhel7-power8le/
        export MODULEPATH=$MODULEPATH:/home/flopez/spack/share/spack/modules/linux-rhel7-power9le/
        # module load gcc-8.3.0-gcc-4.8.5-v6brhfy
        module load gcc-7.4.0-gcc-8.3.0-obdb6j6
        # module load cuda-10.2.89-gcc-8.3.0-wcda5zk
        module load cuda/local
        module load libpciaccess-0.13.5-gcc-8.3.0-2jgej6i
        module load libxml2-2.9.9-gcc-8.3.0-hoz6ovf
        # module load hwloc-1.11.11-gcc-8.3.0-usy4vl5
        module load hwloc/1.11.13
        module load starpu/1.3.3-omp
        module load cmake-3.17.1-gcc-8.3.0-7cbwbeh
        module load htop-2.2.0-gcc-8.3.0-ipu4hm6
        ;;

    login*)
        module load cmake/3.17.3
        module load gcc/8.1.1
        module load netlib-lapack/3.8.0
        module load netlib-scalapack/2.0.2
        module load cuda/10.1.243
        module load essl/6.1.0-2
        module load parsec-mermoz/xl-16.1.1-5-dtd-dev_cuda-debug
        
esac

#-------------------------------------------------------------
# alias
#-------------------------------------------------------------

source $HOME/.bash_aliases


# Run local bashrc
if [ -f .bash_local ]; then
    . .bash_local
fi

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

# # added by Anaconda2 2018.12 installer
# # >>> conda init >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$(CONDA_REPORT_ERRORS=false '/home/flopez/anaconda2/bin/conda' shell.bash hook 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     \eval "$__conda_setup"
# else
#     if [ -f "/home/flopez/anaconda2/etc/profile.d/conda.sh" ]; then
#         . "/home/flopez/anaconda2/etc/profile.d/conda.sh"
#         CONDA_CHANGEPS1=false conda activate base
#     else
#         \export PATH="/home/flopez/anaconda2/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda init <<<
# conda deactivate
