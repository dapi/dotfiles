PACKAGES:=$(PACKAGES) git git-crypt
DOTFILES:=$(DOTFILES) ~/.gitconfig ~/.gitignore_global 
APPLIES:=$(APPLIES) git-hooks

git-pull:
	git pull

git-hooks:
	@git config core.hooksPath .githooks
	@echo "Git hooks path: $$(git config --get core.hooksPath)"
