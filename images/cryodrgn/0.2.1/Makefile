TAG=0.2.1

all: docker singularity

docker:
	sudo docker build . --build-arg CDRGN_VERSION=${TAG} -t slaclab/cryodrgn:${TAG}
	sudo docker push slaclab/cryodrgn:${TAG}

singularity:
	sudo singularity pull -F --name cryodrgn@${TAG}.sif docker://slaclab/cryodrgn:${TAG}
	
