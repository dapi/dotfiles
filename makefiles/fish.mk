tide-configure:
	tide configure --auto --style=Lean --prompt_colors='True color' --show_time=No --lean_prompt_height='One line' --prompt_spacing=Compact --icons='Few icons' --transient=No

fish: fish-install fish-backup-config fish-config fisher

fish-install:
	which fish || sudo apt-get install fish

fish-config:
	$(MAKE) link-config CONFIG_PATH=~/.config/fish MY_CONFIG_PATH=~/dotfiles/fish/conf.d
	$(MAKE) link-config CONFIG_PATH=~/.config/fish MY_CONFIG_PATH=~/dotfiles/fish/config.fish

fisher: fisher-install fisher-plugins

fisher-plugins:
	./scripts/install-fish-plugins.fish

fisher-install:
	./scripts/install-fisher.fish
