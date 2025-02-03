vim: vim-install vim-colors vim-config vim-plug-install

vim-config:
	$(MAKE) link-config CONFIG_PATH=~/.vimrc MY_CONFIG_PATH=~/dotfiles/.vimrc

vim-install:
	$(MAKE) install-tool TOOL=vim

vim-plug-install:
	vim -R +PlugInstall +qall

vim-colors:
	test -f ~/.vim/colors || (mkdir ~/.vim/colors && cp ~/.vim/bundle/gruvbox/colors/gruvbox.vim ~/.vim/colors)
