all: submodules git zsh terminal vim vundle nvm rbenv goenv

submodules:
	git submodule init
	git submodule update

fonts:
	cd fonts
	./install.sh

git:
	test -f ~/.gitconfig || ln -s ~/dotfiles/gitconfig ~/.gitconfig
	test -f ~/.gitignore_global || ln -s ~/dotfiles/gitignore_global ~/.gitignore_global

zsh: ~/.oh-my-zsh ~/.zshrc

~/.oh-my-zsh:
	curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh

~/.zshrc:
	ln -s ~/dotfiles/zshrc ~/.zshrc

terminal:
	open ./dapi.terminal

goenv: ~/.goenv

~/.goenv:
	git clone https://github.com/syndbg/goenv.git ~/.goenv

~/.rbenv/plugins/ruby-build:
	git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

rbenv: ~/.rbenv ~/.rbenv/plugins/ruby-build

~/.rbenv:
	git clone https://github.com/rbenv/rbenv.git ~/.rbenv

nvm: ~/.nvm

~/.nvm:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

vim:
	test -f ~/.vimrc || ln -s ~/dotfiles/.vimrc ~/.vimrc

vundle: ~/.vim/bundle/vundle
~/.vim/bundle/vundle:
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle
