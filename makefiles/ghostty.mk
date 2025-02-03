ghostty: ghostty-install ghostty-config

ghostty-install:
	$(MAKE) install-tool TOOL=ghostty

ghostty-config:
	$(MAKE) link-config CONFIG_PATH=~/.config/ghostty MY_CONFIG_PATH=~/dotfiles/ghostty

ghostty-copy-terminfo:
	infocmp -x | ssh ${REMOTE_HOST} -- tic -x -
