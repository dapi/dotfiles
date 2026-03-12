DOTFILES:=${DOTFILES} ~/mise.toml
APPLIES:=$(APPLIES) mise-install

mise-install:
	@echo "Install mise tools"
	@mise install --quiet
