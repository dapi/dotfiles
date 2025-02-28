DOTFILES:=${DOTFILES} ~/.config/ghostty
PACKAGES:=$(PACKAGES) ghostty

ghostty-copy-terminfo:
	infocmp -x | ssh ${REMOTE_HOST} -- tic -x -
