UNAME=$(shell uname)
ifeq ($(UNAME),Darwin)

KARABINER_MODS_DIR := ~/.config/karabiner/assets/complex_modifications
KARABINER_JSON := $(KARABINER_MODS_DIR)/russian-ctrl-alt.json

APPLIES := $(APPLIES) karabiner

karabiner: karabiner-install karabiner-config

karabiner-install:
	@echo "Installing Karabiner-Elements..."
	@brew list --cask karabiner-elements >/dev/null 2>&1 || brew install --cask karabiner-elements

karabiner-config: $(KARABINER_JSON)
	@echo "Karabiner config installed. Enable rules in Karabiner-Elements -> Complex Modifications"

$(KARABINER_JSON): karabiner/russian-ctrl-alt.json
	@mkdir -p $(KARABINER_MODS_DIR)
	@cp $< $@
	@echo "Copied russian-ctrl-alt.json to Karabiner"

karabiner-enable:
	@echo "Opening Karabiner-Elements preferences..."
	@open "karabiner://karabiner/assets/complex_modifications/"

endif
