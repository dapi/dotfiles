 DOTFILES:=${DOTFILES} ~/.vimrc
vim: vim-install vim-colors vim-plug-install

vim-install:
	@$(MAKE) install-tool TOOL=vim

vim-plug-install:
	@vim -R +PlugInstall +qall

vim-colors:
	@test -e ~/.vim/colors || (mkdir ~/.vim/colors && cp ~/.vim/bundle/gruvbox/colors/gruvbox.vim ~/.vim/colors)
