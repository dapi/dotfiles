APPLIES:=$(APPLIES) nvm

nvm: ~/.nvm
~/.nvm:
	# TODO Update version
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
