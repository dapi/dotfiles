DOTFILES:=${DOTFILES} ~/.config/ghostty

# macOS: Ghostty prioritizes ~/Library/Application Support/com.mitchellh.ghostty/config
# over ~/.config/ghostty/config. If Ghostty already created its default template there,
# our dotfiles config is silently ignored. We back up any real file and symlink to
# the canonical dotfiles location so the repo-managed config is always used.
APPLIES:=$(APPLIES) ghostty-macos-config

ghostty-macos-config:
	@macos_dir="$(HOME)/Library/Application Support/com.mitchellh.ghostty"; \
	macos_config="$$macos_dir/config"; \
	dotfiles_config="$(HOME)/.config/ghostty/config"; \
	if [ ! -e "$$dotfiles_config" ]; then \
		echo "SKIP ghostty-macos-config: $$dotfiles_config not found"; \
		exit 0; \
	fi; \
	if [ -f "$$macos_config" ] && [ ! -L "$$macos_config" ]; then \
		backup="$$macos_config-$$(date '+%F-%T')"; \
		mv "$$macos_config" "$$backup" && echo "Backup $$macos_config to $$backup"; \
	fi; \
	if [ -L "$$macos_config" ]; then \
		current_target="$$(readlink "$$macos_config" 2>/dev/null || true)"; \
		if [ "$$current_target" = "$$dotfiles_config" ]; then \
			exit 0; \
		fi; \
		rm "$$macos_config"; \
	fi; \
	if [ ! -e "$$macos_config" ]; then \
		mkdir -p "$$macos_dir"; \
		echo "Link $$macos_config to $$dotfiles_config"; \
		ln -s "$$dotfiles_config" "$$macos_config"; \
	fi

# Patch xterm-ghostty terminfo (adds Ss/Se cursor shape, Cs/Cr cursor color,
# Ms clipboard, BE/BD bracketed paste, fe/fd focus events, smxx/rmxx strikethrough)
APPLIES:=$(APPLIES) ghostty-terminfo

ghostty-terminfo:
	@if command -v tic >/dev/null 2>&1; then \
		echo "Compile patched xterm-ghostty terminfo"; \
		tic -x $(CURDIR)/xterm-ghostty.terminfo; \
	else \
		echo "SKIP ghostty-terminfo: tic not found"; \
	fi
