#!/bin/bash -l
 
#BSUB -P cryoem                          # project code
#BSUB -J XXXnameXXX                      # job name
#BSUB -q XXXqueueXXX                     # queue
#BSUB -n XXXmpinodesXXX                  # request X slots (cpu cores) for this job
#BSUB -R "span[hosts=1]"                 # request all resources on a single physical host
#BSUB -W XXXextra1XXX                    # Estimated job wall clock limit hh:mm
#BSUB -e XXXerrfileXXX                   # error file name - compatible with GUI
#BSUB -o XXXoutfileXXX                   # output file name - compatible with GUI
#BSUB -B                                 # email status notifications
 
# setup environment
source /etc/profile.d/modules.sh
export MODULEPATH=/usr/share/Modules/modulefiles:/opt/modulefiles:/afs/slac/package/singularity/modulefiles
module purge
module load PrgEnv-gcc/4.8.5
module load relion/2.1

# set tmpdir for relion
export TMPDIR=/scratch/${USER}/${LSB_JOBID}/TMPDIR/

# run relion
mpirun XXXcommandXXX 
