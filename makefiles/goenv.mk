APPLIES:=$(APPLIES) goenv

goenv: ~/.goenv

~/.goenv:
	# TODO Update version
	git clone https://github.com/syndbg/goenv.git ~/.goenv
