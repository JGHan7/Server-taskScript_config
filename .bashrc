# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

## cmake
export PATH=/home/jghan/resource/cmake-3.27.8-linux-x86_64/bin:$PATH


## octopus
module load intel20u4
module load octopus-11.4


## abacus
module add gcc10.2
module add intel20u4
export LD_LIBRARY_PATH=/home/apps/gcc10.2/lib64/:$LD_LIBRARY_PATH
export PATH=/home/jghan/software/abacus-develop/bin:$PATH


## ssh_key
# eval "$(ssh-agent -s)"










