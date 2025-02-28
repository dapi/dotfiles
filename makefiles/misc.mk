guard-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi
sshbg:
	curl https://github.com/fboender/sshbg/blob/855ade6b3c4f9f54ffb739aaf71a2e9baa8cf170/sshbg > ~/.bin/sshbg
	chmod a+x ~/.bin/sshbg
