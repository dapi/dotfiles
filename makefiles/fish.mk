APPLIES:=$(APPLIES) fish-layout fisher
PACKAGES:=$(PACKAGES) fish

# Individual file symlinks — conf.d/ and functions/ stay real dirs so fisher can manage plugins
DOTFILES:=${DOTFILES} ~/.config/fish/config.fish ~/.config/fish/fish_plugins
DOTFILES:=${DOTFILES} ~/.config/fish/conf.d/aliases.fish ~/.config/fish/conf.d/brew.fish
DOTFILES:=${DOTFILES} ~/.config/fish/conf.d/custom-envs.fish ~/.config/fish/conf.d/macos.fish
DOTFILES:=${DOTFILES} ~/.config/fish/functions/kimi-claude.fish ~/.config/fish/functions/proxy.fish ~/.config/fish/functions/zai.fish

# Migrate old directory-level symlinks to real dirs so fisher can manage plugins.
# Also ensure fish files are linked even when running `make apply` without `make dotfiles`.
fish-layout:
	@mkdir -p $(HOME)/.config/fish
	@if [ -L $(HOME)/.config/fish/conf.d ]; then \
		backup="$$(date "+%Y%m%d-%H%M%S")"; \
		if mv $(HOME)/.config/fish/conf.d $(HOME)/.config/fish/conf.d.bak.$$backup; then \
			echo "Migrated ~/.config/fish/conf.d symlink to ~/.config/fish/conf.d.bak.$$backup"; \
		fi; \
	fi
	@if [ -L $(HOME)/.config/fish/functions ]; then \
		backup="$$(date "+%Y%m%d-%H%M%S")"; \
		if mv $(HOME)/.config/fish/functions $(HOME)/.config/fish/functions.bak.$$backup; then \
			echo "Migrated ~/.config/fish/functions symlink to ~/.config/fish/functions.bak.$$backup"; \
		fi; \
	fi
	@mkdir -p $(HOME)/.config/fish/conf.d $(HOME)/.config/fish/functions
	@for completion in fisher.fish spark.fish tide.fish direnv.fish; do \
		if [ -f "$(HOME)/.config/fish/completions/$$completion" ] && [ ! -L "$(HOME)/.config/fish/completions/$$completion" ]; then \
			backup="$$(date "+%Y%m%d-%H%M%S")"; \
			mv "$(HOME)/.config/fish/completions/$$completion" "$(HOME)/.config/fish/completions/$$completion.bak.$$backup"; \
			echo "Backed up ~/.config/fish/completions/$$completion to ~/.config/fish/completions/$$completion.bak.$$backup"; \
		fi; \
	done
	@$(MAKE) link-home-config DST=$(HOME)/.config/fish/config.fish
	@$(MAKE) link-home-config DST=$(HOME)/.config/fish/fish_plugins
	@$(MAKE) link-home-config DST=$(HOME)/.config/fish/conf.d/aliases.fish
	@$(MAKE) link-home-config DST=$(HOME)/.config/fish/conf.d/brew.fish
	@$(MAKE) link-home-config DST=$(HOME)/.config/fish/conf.d/custom-envs.fish
	@$(MAKE) link-home-config DST=$(HOME)/.config/fish/conf.d/macos.fish
	@$(MAKE) link-home-config DST=$(HOME)/.config/fish/functions/kimi-claude.fish
	@$(MAKE) link-home-config DST=$(HOME)/.config/fish/functions/proxy.fish
	@$(MAKE) link-home-config DST=$(HOME)/.config/fish/functions/zai.fish

fisher: fish-layout fisher-install fisher-plugins tide-configure

fisher-install:
	@echo 'Install fisher'
	@./scripts/install-fisher.fish

fisher-plugins:
	@echo 'Install fisher plugins'
	@./scripts/install-fish-plugins.fish

tide-configure:
	@fish -c 'tide configure --auto --style=Lean --prompt_colors="True color" --show_time=No --lean_prompt_height="One line" --prompt_spacing=Compact --icons="Few icons" --transient=No'
