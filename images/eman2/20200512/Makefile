TAG=20200512
REV=0

build:
	sudo docker build . -t slaclab/eman2:${TAG}.${REV}
	sudo docker push slaclab/eman2:${TAG}.${REV}

singularity:
	sudo singularity pull -F /afs/slac/package/singularity/images/eman2/${TAG}/eman2@${TAG}.sif docker://slaclab/eman2:${TAG}.${REV}
