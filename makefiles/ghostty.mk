DOTFILES:=${DOTFILES} ~/.config/ghostty
UNAME=$(shell uname)

.PHONY: ghostty
ghostty:
ifeq ($(UNAME),Darwin)
	@$(MAKE) ghostty-macos
endif

ghostty-macos: ghostty-install 

ghostty-install:
	@$(MAKE) install-tool TOOL=ghostty

ghostty-copy-terminfo:
	infocmp -x | ssh ${REMOTE_HOST} -- tic -x -
