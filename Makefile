MAKEFLAGS += --no-print-directory

include configuration.mk
include makefiles/*.mk

.DEFAULT_GOAL := all

.PHONY: $(DOTFILES)
$(DOTFILES):
	@$(MAKE) link-home-config DST=$@
dotfiles: $(DOTFILES)

.PHONY: $(PACKAGES)
$(PACKAGES):
	@$(MAKE) package PACKAGE=$@
packages: $(PACKAGES)

.PHONY: $(APPLIES)
apply: $(APPLIES)

all: packages dotfiles apply

update: git-pull all
