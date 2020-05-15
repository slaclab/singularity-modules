TAG=4.0.1

all:
	sudo docker build . -t slaclab/openmpi:${TAG}
	sudo docker push slaclab/openmpi:${TAG}
	sudo singularity pull -F docker://slaclab/openmpi:${TAG}

