all: submodules git zsh terminal vim vundle nvm rbenv goenv direnv ctags etc nvim ag

submodules:
	git submodule init
	git submodule update

fonts:
	cd fonts
	./install.sh

ctags: ~/.ctags
	which ctags || brew install ctags

git: ~/.gitconfig ~/.gitignore_global
	which git || brew install git

~/.gitconfig:
	ln -s ~/dotfiles/gitconfig ~/.gitconfig

~/.gitignore_global:
	ln -s ~/dotfiles/gitignore_global ~/.gitignore_global

zsh: ~/.oh-my-zsh ~/.zshrc

~/.oh-my-zsh:
	curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh

~/.zshrc:
	ln -s ~/dotfiles/zshrc ~/.zshrc

terminal:
	@echo "open ./dapi.terminal"

goenv: ~/.goenv
~/.goenv:
	git clone https://github.com/syndbg/goenv.git ~/.goenv

~/.rbenv/plugins/ruby-build:
	git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

rbenv: ~/.rbenv ~/.rbenv/plugins/ruby-build
~/.rbenv:
	git clone https://github.com/rbenv/rbenv.git ~/.rbenv

nvm: ~/.nvm
~/.nvm:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

~/.config/nvim/init.vim:
	ln -s ~/dotfiles/.vimrc ~/.config/nvim/init.vim
~/.vimrc:
	ln -s ~/dotfiles/.vimrc ~/.vimrc

vim: ~/.vimrc ~/.vim/bundle/vundle
	which vim || (brew install vim && vim -R +PluginInstall +qall)

nvim: ~/.config/nvim/init.vim ~/.vim/bundle/vundle
	which nvim || (brew install neovim && nvim -R +PluginInstall +qall)

vundle: ~/.vim/bundle/vundle
~/.vim/bundle/vundle:
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle

direnv:
	which direnv || brew install direnv

~/.irbrc:
	ln -s ~/dotfiles/irbrc ~/.irbrc
~/.rdebugrc:
	ln -s ~/dotfiles/rdebugrc ~/.rdebugrc

~/.ackrc:
	ln -s ~/dotfiles/ackrc ~/.ackrc

~/.ctags:
	ln -s ~/dotfiles/ctags ~/.ctags

~/.pryrc:
	ln -s ~/dotfiles/pryrc ~/.pryrc

~/.tmux.conf:
	ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

~/.psqlrc:
	ln -s ~/dotfiles/psqlrc ~/.psqlrc

~/.gemrc:
	ln -s ~/dotfiles/gemrc ~/.gemrc

~/.agignore:
	ln -s ~/dotfiles/agignore ~/.agignore

etc: ~/.irbrc ~/.rdebugrc ~/.ackrc ~/.pryrc ~/.tmux.conf ~/.psqlrc ~/.gemrc

ag: ~/.agignore
	which ag || brew insall ag
