PROGRAM=matlab
TAG=R2020a

docker:
	#sudo docker build . -t slaclab/${PROGRAM}:${TAG}
	#sudo docker push slaclab/${PROGRAM}:${TAG}
	sudo singularity build -F /afs/slac/package/singularity/images/${PROGRAM}/${TAG}/${PROGRAM}@${TAG}.sif Singularityfile
