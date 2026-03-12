APPLIES:=$(APPLIES) fish-layout fisher
PACKAGES:=$(PACKAGES) fish

# conf.d/ symlinked as whole dir; fisher-managed files (.gitignore'd)
# functions/ stays a real dir — fisher puts dozens of files there
DOTFILES:=${DOTFILES} ~/.config/fish/config.fish ~/.config/fish/fish_plugins
DOTFILES:=${DOTFILES} ~/.config/fish/conf.d
DOTFILES:=${DOTFILES} ~/.config/fish/functions/kimi-claude.fish ~/.config/fish/functions/proxy.fish ~/.config/fish/functions/zai.fish ~/.config/fish/functions/ssh.fish

# Migrate old directory-level symlinks to real dirs so fisher can manage plugins.
# Also ensure fish files are linked even when running `make apply` without `make dotfiles`.
# Completions are managed by fisher in a real directory, so don't re-backup them on each run.
fish-layout:
	@mkdir -p $(HOME)/.config/fish
	@if [ -L $(HOME)/.config/fish/functions ]; then \
		backup="$$(date "+%Y%m%d-%H%M%S")"; \
		if mv $(HOME)/.config/fish/functions $(HOME)/.config/fish/functions.bak.$$backup; then \
			echo "Migrated ~/.config/fish/functions symlink to ~/.config/fish/functions.bak.$$backup"; \
		fi; \
	fi
	@mkdir -p $(HOME)/.config/fish/functions
	@mkdir -p $(HOME)/.config/fish/completions

fisher: fish-layout fisher-install fisher-plugins tide-configure

fisher-install:
	@echo 'Install fisher'
	@./scripts/install-fisher.fish

fisher-plugins:
	@echo 'Install fisher plugins'
	@./scripts/install-fish-plugins.fish

tide-configure:
	@fish -C 'function clear; end' -c 'tide configure --auto --style=Lean --prompt_colors="True color" --show_time=No --lean_prompt_height="One line" --prompt_spacing=Compact --icons="Few icons" --transient=No'
