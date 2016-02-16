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

# add global modulefile directory
module use --append /numerical/flopez/modulefiles

# load default modules
module load gnu/comp/default
module load hwloc/1.11.2
module load fxt/0.3.1
module load gnu/mkl/seq/11.2.0
module load hsl/latest
