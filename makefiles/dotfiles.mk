DOTFILES=~/.irbrc ~/.rdebugrc ~/.ackrc ~/.pryrc ~/.tmux.conf ~/.psqlrc ~/.gemrc ~/.ctags ~/.agignore ~/.gitconfig ~/.gitignore_global
dotfiles: $(DOTFILES)

.PHONY:
$(DOTFILES):
	$(MAKE) link-home-config FILE=$@
