#!/bin/sh

IMAGE=/afs/slac/package/singularity/./images/phenix/1.14-3260/phenix@1.14-3260.simg
SINGULARITY=singularity
GPU=
LSF=

MOUNTS=''
if [ -d /gpfs ]; then
  MOUNTS='/gpfs'
fi
if [ -d /nfs ]; then
  MOUNTS=$MOUNTS,/nfs
fi
if [ -d /scratch ]; then
  MOUNTS=$MOUNTS,/scratch
fi 
if [ -d /afs ]; then
  MOUNTS=$MOUNTS,/afs
fi

if [ "$LSF" == "1" ]; then
  LSF=" -B /afs/slac/package/lsf:/opt/lsf "
fi
exec ${SINGULARITY} exec ${GPU} -B ${MOUNTS} ${LSF}  ${IMAGE} $(basename "$0")  "$@"
