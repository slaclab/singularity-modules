
TAG=ver3.1
IMAGE=slaclab/relion
SINGULARITY_DIR=/afs/slac/package/singularity/images/relion/${TAG}
#ARCH=skylake-avx512
#IMAGE_ARCH=^CPU_GEN:SKX
ARCH=haswell
IMAGE_ARCH=^CPU_GEN:HSW

docker:
	sudo docker build . --build-arg ARCH=${ARCH} -t ${IMAGE}:${TAG}-${ARCH}
	sudo docker push  ${IMAGE}:${TAG}-${ARCH}

singularity:
	mkdir -p ${SINGULARITY_DIR}
	sudo singularity pull -F ${SINGULARITY_DIR}/relion@${TAG}${IMAGE_ARCH}.sif docker://${IMAGE}:${TAG}-${ARCH}
