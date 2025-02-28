UNAME=$(shell uname)
APPLIES:=${APPLIES} macos-install

macos-install:
ifeq ($(UNAME),Darwin)
	@echo "Check Rosetta"
	@arch -x86_64 /usr/bin/true || \
		softwareupdate --install-rosetta --agree-to-license
endif
