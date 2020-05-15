#!/bin/bash -l
 
#BSUB -P cryoem
#BSUB -J XXXnameXXX
#BSUB -q XXXqueueXXX
#BSUB -n XXXmpinodesXXX
#BSUB -R "span[hosts=1]"
#BSUB -W XXXextra1XXX
#BSUB -e XXXerrfileXXX
#BSUB -o XXXoutfileXXX
#BSUB -B
 
# setup environment
source /etc/profile.d/modules.sh
export MODULEPATH=/usr/share/Modules/modulefiles:/opt/modulefiles:/afs/slac/package/singularity/modulefiles
module purge
module load PrgEnv-gcc/4.8.5
module load relion/3.0

# set tmpdir for relion
export TMPDIR=/scratch/${USER}/${LSB_JOBID}/TMPDIR/

# run the relion job, ensure we ask for one gpu per remaining rank/process. more than 2 or 3 threads (--j) is not productive
mpirun XXXcommandXXX 
