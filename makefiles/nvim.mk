DOTFILES:=${DOTFILES} ~/.config/nvim
PACKAGES:=${PACKAGES} nvim
APPLIES:=${APPLIES} nvim-install

nvim-install: nvim-plug-install nvim-plugins-install

nvim-reinstall: nvim-clean nvim-install

NVIM_PLUG_DIR:=$(shell echo $${XDG_DATA_HOME:-$$HOME/.local/share})
NVIM_PLUG_FILE=${NVIM_PLUG_DIR}/nvim/site/autoload/plug.vim

nvim-plug-install: $(NVIM_PLUG_FILE)

$(NVIM_PLUG_FILE):
	@sh -c 'curl -fLo ${NVIM_PLUG_FILE} --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim-plugins-install:
	@nvim -R +PlugInstall +qall

nvim-clean:
	@test ! -d ~/.config/nvim || mv ~/.config/nvim ~/.config/nvim-$(shell date "+%F-%T")

nvim-lsponfig:
	git clone https://github.com/neovim/nvim-lspconfig ~/.config/nvim/pack/nvim/start/nvim-lspconfig

