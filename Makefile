MAKEFLAGS += --no-print-directory

include configuration.mk
include makefiles/*.mk

.DEFAULT_GOAL := all

.PHONY: bootstrap $(BOOTSTRAPS) $(DOTFILES) dotfiles-status
$(DOTFILES):
	@dst="$@"; \
	repo_dir="$(CURDIR)"; \
	reference_file="$${dst#$(HOME)/}"; \
	reference="$$repo_dir/$$reference_file"; \
	dst_reference="$$(readlink "$$dst" 2>/dev/null || true)"; \
	if [ -L "$$dst" ] && [ "$$dst_reference" = "$$reference" ]; then \
		exit 0; \
	fi; \
	if [ -e "$$dst" ] || [ -L "$$dst" ]; then \
		backup="$$dst-$$(date "+%F-%T")"; \
		mv "$$dst" "$$backup" && echo "Backup $$dst to $$backup"; \
	fi; \
	mkdir -p "$$(dirname "$$dst")"; \
	echo "Link ~/$$reference_file to $$reference"; \
	ln -s "$$reference" "$$dst"

dotfiles-status:
	@echo "Sync dotfiles"

dotfiles: dotfiles-status $(DOTFILES)

bootstrap: $(BOOTSTRAPS)

.PHONY: $(PACKAGES)
$(PACKAGES):
	@$(MAKE) package PACKAGE=$@
packages: $(PACKAGES)

.PHONY: $(APPLIES)
apply: bootstrap $(APPLIES)

all: bootstrap packages dotfiles apply

update: git-pull all
