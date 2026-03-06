DOTFILES:=${DOTFILES} ~/.vimrc
APPLIES:=$(APPLIES) vim-install
PACKAGES:=$(PACKAGES) vim

vim-install: vim-colors

vim-plug-install:
	@echo "Skip vim PlugInstall: plugins are managed via nvim-install"

vim-colors:
	#@test -e ~/.vim || mkdir ~/.vim
	#@test -e ~/.vim/colors || (mkdir ~/.vim/colors && cp ~/.vim/bundle/gruvbox/colors/gruvbox.vim ~/.vim/colors)
