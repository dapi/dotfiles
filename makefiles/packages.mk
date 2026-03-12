PACKAGES:=$(PACKAGES) mise bc

UNAME := $(shell uname)

# Маппинг: логическое имя → имя в brew
BREW_NAME_ag = the_silver_searcher
BREW_NAME_nvim = neovim
BREW_NAME_exuberant-ctags = universal-ctags

# Маппинг: логическое имя → имя бинаря в PATH
CMD_NAME_exuberant-ctags = ctags

# Маппинг: логическое имя → имя в apt
APT_NAME_ag = silversearcher-ag

# Функции получения реального имени пакета
brew_name = $(or $(BREW_NAME_$(1)),$(1))
apt_name = $(or $(APT_NAME_$(1)),$(1))
cmd_name = $(or $(CMD_NAME_$(1)),$(1))

package:
ifeq ($(UNAME),Darwin)
	@if command -v $(call cmd_name,${PACKAGE}) > /dev/null 2>&1; then \
		echo "Install ${PACKAGE} - already exists"; \
	else \
		brew install $(call brew_name,${PACKAGE}) && echo "Install ${PACKAGE} - installed"; \
	fi
else
	@if command -v $(call cmd_name,${PACKAGE}) > /dev/null 2>&1; then \
		echo "Install ${PACKAGE} - already exists"; \
	else \
		sudo apt-get install -y $(call apt_name,${PACKAGE}) && echo "Install ${PACKAGE} - installed"; \
	fi
endif
