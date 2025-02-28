DOTFILES:=${DOTFILES} ~/.config/fish/conf.d ~/.config/fish/config.fish

tide-configure:
	tide configure --auto --style=Lean --prompt_colors='True color' --show_time=No --lean_prompt_height='One line' --prompt_spacing=Compact --icons='Few icons' --transient=No

fish: fish-install fisher

fish-install:
	@$(MAKE) install-tool TOOL=fish

fisher: fisher-install fisher-plugins

fisher-plugins:
	@echo 'Install fisher plugins'
	@./scripts/install-fish-plugins.fish

fisher-install:
	@echo 'Install fisher'
	@./scripts/install-fisher.fish
