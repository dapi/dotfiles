PACKAGES:=$(PACKAGES) git git-crypt
DOTFILES:=$(DOTFILES) ~/.gitconfig ~/.gitignore_global 

git-pull:
	git pull
