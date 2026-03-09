PACKAGES:=$(PACKAGES) mise bc

UNAME := $(shell uname)

# Маппинг: логическое имя → имя в brew
BREW_NAME_ag = the_silver_searcher
BREW_NAME_nvim = neovim
BREW_NAME_exuberant-ctags = universal-ctags

# Маппинг: логическое имя → имя в apt
APT_NAME_ag = silversearcher-ag

# Функции получения реального имени пакета
brew_name = $(or $(BREW_NAME_$(1)),$(1))
apt_name = $(or $(APT_NAME_$(1)),$(1))

package:
	@echo "Install ${PACKAGE}"
ifeq ($(UNAME),Darwin)
	@which ${PACKAGE} > /dev/null 2>&1 || brew install $(call brew_name,${PACKAGE})
else
	@which ${PACKAGE} > /dev/null 2>&1 || sudo apt-get install -y $(call apt_name,${PACKAGE})
endif
