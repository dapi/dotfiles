UNAME=$(shell uname)
ifeq ($(UNAME),Darwin)
APPLIES:=${APPLIES} macos-install

macos-install:
	@echo "Check Rosetta"
	@arch -x86_64 /usr/bin/true || \
		softwareupdate --install-rosetta --agree-to-license

DOTFILES:=${DOTFILES} ~/.config/ghostty
PACKAGES:=$(PACKAGES) ghostty

ghostty-copy-terminfo:
	infocmp -x | ssh ${REMOTE_HOST} -- tic -x -

APPLIES:=$(APPLIES) brew

brew: brew-install brew-packages

brew-packages:
	brew install --cask amneziavpn

brew-install:
	which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
endif
