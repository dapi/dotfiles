APPLIES:=$(APPLIES) fisher
DOTFILES:=${DOTFILES} ~/.config/fish/conf.d ~/.config/fish/config.fish ~/.config/fish/functions
PACKAGES:=$(PACKAGES) fish

fisher: fisher-install

fisher-install:
	@echo 'Install fisher'
	@./scripts/install-fisher.fish
