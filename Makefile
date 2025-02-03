TEMP_DATE:=$(shell date "+%F-%T")
HOMEBREW_NO_AUTO_UPDATE=1

include makefiles/*.mk

.DEFAULT_GOAL := all
all: fonts git zsh vim nvm rbenv goenv ctags nvim ag dotfiles fish ghostty

update: git-pull all

sshbg:
	curl https://github.com/fboender/sshbg/blob/855ade6b3c4f9f54ffb739aaf71a2e9baa8cf170/sshbg > ~/.bin/sshbg
	chmod a+x ~/.bin/sshbg

goenv: ~/.goenv
~/.goenv:
	# TODO Update version
	git clone https://github.com/syndbg/goenv.git ~/.goenv

nvm: ~/.nvm
~/.nvm:
	# TODO Update version
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

ag: .agignore
	@$(MAKE) install-tool TOOL=ag
