
DOTFILES=.irbrc .rdebugrc .ackrc .pryrc .tmux.conf .psqlrc .gemrc .ctags .agignore .gitconfig .gitignore_global

dotfiles: $(DOTFILES)

.PHONY: $(DOTFILES)
$(DOTFILES):
	@$(MAKE) link-home-config FILE=$@
