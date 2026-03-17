# GnuPG pinentry and agent forwarding setup

# ── Linux ────────────────────────────────────────────────────────────────────
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

# Run once to allow SSH RemoteForward to overwrite the GPG agent socket.
# Required for GPG agent forwarding from macOS.
gnupg-forward-linux:
	@echo "Configuring sshd for GPG agent forwarding..."
	@echo "StreamLocalBindUnlink yes" | sudo tee /etc/ssh/sshd_config.d/gpg-forward.conf
	@sudo sshd -t && echo "sshd config OK"
	@sudo systemctl reload ssh && echo "sshd reloaded"
	@echo "Done. Reconnect SSH from macOS to activate GPG forwarding."

# ── macOS ────────────────────────────────────────────────────────────────────
# macOS uses pinentry-mac for Keychain integration.
# The gpg-agent.conf symlink is replaced with a generated file containing
# the pinentry path resolved via `brew --prefix`.

ifeq ($(UNAME),Darwin)
PACKAGES:=$(PACKAGES) pinentry-mac
APPLIES:=$(APPLIES) gnupg-pinentry-mac
endif

gnupg-pinentry-mac:
	@echo "Setting up macOS gpg-agent with pinentry-mac..."
	@BREW_PREFIX=$$(brew --prefix 2>/dev/null || echo /opt/homebrew); \
	 PINENTRY="$$BREW_PREFIX/bin/pinentry-mac"; \
	 if [ ! -f "$$PINENTRY" ]; then \
	   echo "ERROR: pinentry-mac not found at $$PINENTRY — run: brew install pinentry-mac"; exit 1; \
	 fi; \
	 DEST="$$HOME/.gnupg/gpg-agent.conf"; \
	 rm -f "$$DEST"; \
	 sed "s|PINENTRY_PLACEHOLDER|$$PINENTRY|g" "$(CURDIR)/.gnupg/gpg-agent.macos.conf" > "$$DEST"; \
	 echo "Written $$DEST with pinentry=$$PINENTRY"; \
	 EXTRA_SOCKET=$$(gpgconf --list-dirs agent-extra-socket 2>/dev/null); \
	 echo "GPG extra socket: $$EXTRA_SOCKET"; \
	 echo "  → Make sure office2.conf RemoteForward local path matches $$EXTRA_SOCKET"; \
	 gpgconf --kill gpg-agent; \
	 gpgconf --launch gpg-agent; \
	 echo "gpg-agent restarted"
