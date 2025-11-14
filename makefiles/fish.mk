APPLIES:=$(APPLIES) fisher
DOTFILES:=${DOTFILES} ~/.config/fish/conf.d ~/.config/fish/config.fish ~/.config/fish/functions

tide-configure:
	tide configure --auto --style=Lean --prompt_colors='True color' --show_time=No --lean_prompt_height='One line' --prompt_spacing=Compact --icons='Few icons' --transient=No

fisher: fisher-install fisher-plugins

fisher-plugins:
	@echo 'Install fisher plugins'
	@./scripts/install-fish-plugins.fish

fisher-install:
	@echo 'Install fisher'
	@./scripts/install-fisher.fish
