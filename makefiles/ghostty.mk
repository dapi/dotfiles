DOTFILES:=${DOTFILES} ~/.config/ghostty

# Patch xterm-ghostty terminfo (adds Ss/Se cursor shape, Cs/Cr cursor color,
# Ms clipboard, BE/BD bracketed paste, fe/fd focus events, smxx/rmxx strikethrough)
APPLIES:=$(APPLIES) ghostty-terminfo

ghostty-terminfo:
	@if command -v tic >/dev/null 2>&1; then \
		echo "Compile patched xterm-ghostty terminfo"; \
		tic -x $(CURDIR)/xterm-ghostty.terminfo; \
	else \
		echo "SKIP ghostty-terminfo: tic not found"; \
	fi
