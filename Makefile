TEMP_DATE:=$(shell date "+%F-%T")
HOMEBREW_NO_AUTO_UPDATE=1

include makefiles/shared.mk makefiles/ghostty.mk makefiles/nvim.mk makefiles/vim.mk makefiles/fish.mk makefiles/fonts.mk makefiles/zsh.mk

all: fonts git zsh terminal vim vundle nvm rbenv goenv ctags etc nvim ag dotfiles

update: git-pull fonts fish nvim ghostty

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

ag: ~/.agignore
	which ag || brew install ag
