TAG=master

docker:
	sudo docker build . -t slaclab/cryodrgn:${TAG}
	sudo docker push slaclab/cryodrgn:${TAG}

singularity:
	sudo singularity pull -F --name cryodrgn@${TAG}.sif docker://slaclab/cryodrgn:${TAG}
	
