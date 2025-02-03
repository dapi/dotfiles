nvim: nvim-install nvim-plug-install nvim-check-and-backup nvim-config nvim-plugins-install

nvim-reinstall: nvim-clean nvim

nvim-plug-install:
	sh -c 'curl -fLo "$${XDG_DATA_HOME:-$$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
				 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim-plugins-install:
	nvim -R +PlugInstall +qall

nvim-clean:
	test ! -d ~/.config/nvim || mv ~/.config/nvim ~/.config/nvim-$(shell date "+%F-%T")
	
nvim-config: ~/.config/nvim
	$(MAKE) link-config CONFIG_PATH=~/.config/nvim MY_CONFIG_PATH=~/dotfiles/nvim

nvim-install:
	$(MAKE) install-tool TOOL=neovim
