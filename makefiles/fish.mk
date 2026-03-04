APPLIES:=$(APPLIES) fisher
PACKAGES:=$(PACKAGES) fish

# Individual file symlinks — conf.d/ and functions/ stay real dirs so fisher can manage plugins
DOTFILES:=${DOTFILES} ~/.config/fish/config.fish ~/.config/fish/fish_plugins
DOTFILES:=${DOTFILES} ~/.config/fish/conf.d/aliases.fish ~/.config/fish/conf.d/brew.fish
DOTFILES:=${DOTFILES} ~/.config/fish/conf.d/custom-envs.fish ~/.config/fish/conf.d/macos.fish
DOTFILES:=${DOTFILES} ~/.config/fish/functions/kimi-claude.fish ~/.config/fish/functions/proxy.fish ~/.config/fish/functions/zai.fish

# Ensure parent dirs exist before symlinking files into them
fish-dirs:
	@mkdir -p ~/.config/fish/conf.d ~/.config/fish/functions

fisher: fish-dirs fisher-install fisher-plugins tide-configure

fisher-install:
	@echo 'Install fisher'
	@./scripts/install-fisher.fish

fisher-plugins:
	@echo 'Install fisher plugins'
	@./scripts/install-fish-plugins.fish

tide-configure:
	@fish -c 'tide configure --auto --style=Lean --prompt_colors="True color" --show_time=No --lean_prompt_height="One line" --prompt_spacing=Compact --icons="Few icons" --transient=No'
