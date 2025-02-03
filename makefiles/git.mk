git: git-install git-config

git-pull:
	git pull

git-install:
	${MAKE} install-tool git

git-config: ~/.gitconfig ~/.gitignore_global
