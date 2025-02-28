DOTFILES:=${DOTFILES} ~/.vimrc
APPLIES:=$(APPLIES) vim-install
PACKAGES:=$(PACKAGES) vim

vim-install: vim-colors vim-plug-install

vim-plug-install:
	@vim -R +PlugInstall +qall

vim-colors:
	@test -e ~/.vim/colors || (mkdir ~/.vim/colors && cp ~/.vim/bundle/gruvbox/colors/gruvbox.vim ~/.vim/colors)
