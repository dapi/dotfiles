DOTFILES:=${DOTFILES} ~/.ctags
ctags: ctags-install

ctags-install:
	@${MAKE} install-tool TOOL=ctags
