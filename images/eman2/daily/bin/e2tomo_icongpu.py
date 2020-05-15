#!/bin/sh

IMAGE=/afs/slac/package/singularity/./images/eman2/daily/eman2@20190320.simg
SINGULARITY=singularity
GPU=--nv
LSF=1

ENVFILE=`dirname "$0"`/../env
if [[ -L "${ENVFILE}" || -e "${ENVFILE}" ]]; then
  source ${ENVFILE}
fi

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
