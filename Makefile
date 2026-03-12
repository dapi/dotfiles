MAKEFLAGS += --no-print-directory

include configuration.mk
include makefiles/*.mk

.DEFAULT_GOAL := all

.PHONY: $(DOTFILES) dotfiles-status
$(DOTFILES):
	@raw_dst="$@"; \
	dst="$(HOME)/$${raw_dst#~/}"; \
	repo_dir="$(CURDIR)"; \
	reference_file="$${raw_dst#~/}"; \
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

.PHONY: $(PACKAGES)
$(PACKAGES):
	@$(MAKE) package PACKAGE=$@
packages: $(PACKAGES)

.PHONY: $(APPLIES)
apply: $(APPLIES)

all: packages dotfiles apply

update: git-pull all
