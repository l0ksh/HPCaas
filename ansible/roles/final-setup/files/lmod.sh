#!/bin/sh
# -*- shell-script -*-
########################################################################
#  This is the system wide source file for setting up
#  modules:
#
########################################################################

# NOOP if running under known resource manager
if [ ! -z "$SLURM_NODELIST" ];then
     return
fi

if [ ! -z "$PBS_NODEFILE" ];then
    return
fi

export LMOD_SETTARG_CMD=":"
export LMOD_FULL_SETTARG_SUPPORT=no
export LMOD_COLORIZE=no
export LMOD_PREPEND_BLOCK=normal

if [ $EUID -eq 0 ]; then
    export MODULEPATH=/share/modulefiles
else
    export MODULEPATH=/share/modulefiles
fi

export BASH_ENV=/opt/ohpc/admin/lmod/lmod/init/bash

# Initialize modules system
. /opt/ohpc/admin/lmod/lmod/init/bash >/dev/null

# Load baseline OpenHPC environment
module try-add ohpc
