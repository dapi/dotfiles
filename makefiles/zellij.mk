DOTFILES:=${DOTFILES} ~/.config/zellij
APPLIES:=$(APPLIES) zellij-plugins

zellij: ~/.config/zellij zellij-plugins

ZELLIJ_PLUGINS_DIR=~/.config/zellij/plugins
ZELLIJ_TAB_STATUS=$(ZELLIJ_PLUGINS_DIR)/zellij-tab-status.wasm

zellij-plugins: $(ZELLIJ_TAB_STATUS)

$(ZELLIJ_TAB_STATUS):
	@mkdir -p $(ZELLIJ_PLUGINS_DIR)
	@echo "Download zellij-tab-status plugin"
	@curl -fL https://github.com/dapi/zellij-tab-status/releases/latest/download/zellij-tab-status.wasm -o $(ZELLIJ_TAB_STATUS)
