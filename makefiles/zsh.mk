zsh: ~/.oh-my-zsh zsh-config

~/.oh-my-zsh:
	# TODO Обновлять oh-my-zsh если надо
	curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh

zsh-config:
	@$(MAKE) link-home-config FILE=.zshrc 
