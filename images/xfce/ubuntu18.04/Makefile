TAG=ubuntu18.04
SINGULARITY_IMAGE=/afs/slac/package/singularity/images/xfce/${TAG}/xfce@${TAG}.sif

docker:
	sudo docker build . -t slaclab/xfce:${TAG}
	sudo docker push slaclab/xfce:${TAG}
	sudo singularity pull -F --name ${SINGULARITY_IMAGE} docker://slaclab/xfce:${TAG}
