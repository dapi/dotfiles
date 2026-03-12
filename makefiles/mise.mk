DOTFILES:=${DOTFILES} ~/mise.toml
BOOTSTRAPS:=$(BOOTSTRAPS) mise-package mise-install

mise-package:
	@$(MAKE) package PACKAGE=mise

mise-install: mise-package
	@echo "Install mise tools"
	@mise install --quiet
