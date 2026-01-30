APPLIES:=$(APPLIES) oh-my-zsh
DOTFILES:=$(DOTFILES) ~/.zshrc
PACKAGES:=$(PACKAGES) zsh

oh-my-zsh: ~/.oh-my-zsh

~/.oh-my-zsh:
	# TODO Обновлять oh-my-zsh если надо
	curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh
