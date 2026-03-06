APPLIES:=${APPLIES} kubectl

kubectl: ~/bin/kubectl

~/bin/kubectl:
	@mkdir -p ~/bin
	@version="$$(curl -fsSL https://dl.k8s.io/release/stable.txt)"; \
	test -n "$$version"; \
	echo "Install kubectl $$version"; \
	curl -fL --retry 3 --retry-delay 1 -o ~/bin/kubectl "https://dl.k8s.io/release/$$version/bin/linux/amd64/kubectl"; \
	chmod a+x ~/bin/kubectl
