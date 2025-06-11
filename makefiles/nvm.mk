APPLIES:=$(APPLIES) nvm

nvm: ~/.nvm
~/.nvm:
	# TODO Update version
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
