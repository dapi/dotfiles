APPLIES:=${APPLIES} kubectl

kubectl: ~/bin/kubectl

~/bin/kubectl:
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	mv ./kubectl ~/bin
	chmod a+x ~/bin/kubectl
