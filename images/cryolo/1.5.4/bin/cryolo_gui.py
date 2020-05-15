#!/bin/sh

IMAGE=/afs/slac/package/singularity/./images/cryolo/1.5.4/cryolo@1.5.4.sif
SINGULARITY=singularity
GPU=--nv
LSF=1

ENVFILE=`dirname "$0"`/../env
if [[ -L "${ENVFILE}" || -e "${ENVFILE}" ]]; then
  source ${ENVFILE}
fi

arch=$( /afs/slac/package/singularity/node_features.sh --no-gpu | grep 'CPU_GEN' )
fn=$(basename -- "$IMAGE")
image=${IMAGE%.*}^$arch.${fn##*.}
if [ -e "$image" ]; then
  IMAGE=$image
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
