#!/bin/bash -l
 
#BSUB -P cryoem
#BSUB -J XXXnameXXX
#BSUB -q XXXqueueXXX
#BSUB -n XXXmpinodesXXX
#BSUB -W XXXextra1XXX
#BSUB -e XXXerrfileXXX
#BSUB -o XXXoutfileXXX
#BSUB XXXextra5XXX
#BSUB -B
 
# other
# threads: XXXthreadsXXX
# cores: XXXcoresXXX
# dedicated: XXXdedicatedXXX
# mem: XXXextra2XXX
# unused: XXXextra3XXX

# setup environment
source /etc/profile.d/modules.sh
export MODULEPATH=/usr/share/Modules/modulefiles:/opt/modulefiles:/afs/slac/package/singularity/modulefiles
module purge
module load PrgEnv-gcc
module load relion/3.0.4

# set tmpdir for relion
export TMPDIR=/scratch/${USER}/${LSB_JOBID}/TMPDIR/

# run relion
mpirun XXXcommandXXX 
