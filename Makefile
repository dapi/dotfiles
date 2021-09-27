all: submodules git zsh terminal

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
	echo 123
	curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh
~/.zshrc:
	echo "zshrc"

terminal:
	open ./dapi.terminal
