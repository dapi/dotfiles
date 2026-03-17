# GnuPG pinentry setup (Linux only)
# macOS uses pinentry-curses which works fine with stable TTYs.
# Linux headless servers need pinentry-tty to avoid gpg-agent crashes
# when TTY is unavailable (background processes, Claude Code, etc.)

ifeq ($(UNAME),Linux)
PACKAGES:=$(PACKAGES) pinentry-tty
APPLIES:=$(APPLIES) gnupg-pinentry
endif

gnupg-pinentry:
	@if [ "$(UNAME)" = "Linux" ]; then \
		sudo update-alternatives --set pinentry /usr/bin/pinentry-tty && \
		echo "pinentry set to pinentry-tty"; \
		gpg-connect-agent reloadagent /bye 2>/dev/null || true; \
	fi
