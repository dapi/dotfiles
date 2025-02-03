TEMP_DATE:=$(shell date "+%F-%T")
HOMEBREW_NO_AUTO_UPDATE=1

all: fonts git zsh terminal vim vundle nvm rbenv goenv ctags etc nvim ag

update: git-pull fonts fish nvim ghostty

git-pull:
	git pull

fonts: hack-nerd-font

hack-nerd-font:
	brew install font-hack-nerd-font

powerline-fonts:
	git clone https://github.com/powerline/fonts.git ./powerline-fonts
	(cd powerline-fonts; ./install.sh)

sshbg:
	curl https://github.com/fboender/sshbg/blob/855ade6b3c4f9f54ffb739aaf71a2e9baa8cf170/sshbg > ~/.bin/sshbg
	chmod a+x ~/.bin/sshbg

ctags: ctags-install ~/.ctags

ctags-install:
	which ctags || brew install ctags

git: git-install ~/.gitconfig ~/.gitignore_global

ghostty-copy-terminfo:
	infocmp -x | ssh office.brandymint.ru -- tic -x -

git-install:
	which git || brew install git

# Copy to safe customize
~/.gitconfig:
	cp ~/dotfiles/.gitconfig ~/.gitconfig

~/.gitignore_global:
	ln -fs ~/dotfiles/.gitignore_global ~/.gitignore_global

zsh: ~/.oh-my-zsh ~/.zshrc

~/.oh-my-zsh:
	curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh

~/.zshrc:
	ln -fs ~/dotfiles/.zshrc ~/.zshrc

goenv: ~/.goenv
~/.goenv:
	git clone https://github.com/syndbg/goenv.git ~/.goenv

~/.rbenv/plugins/ruby-build:
	git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

rbenv: ~/.rbenv ~/.rbenv/plugins/ruby-build
~/.rbenv:
	git clone https://github.com/rbenv/rbenv.git ~/.rbenv

nvm: ~/.nvm
~/.nvm:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

~/.vimrc:
	ln -fs ~/dotfiles/.vimrc ~/.vimrc

vim: vim-install ~/.vimrc ~/.vim/bundle/vundle
vim-install:
	which vim || (brew install vim && vim -R +PluginInstall +qall)

vim-colors:
	test -f ~/.vim/colors || (mkdir ~/.vim/colors && cp ~/.vim/bundle/gruvbox/colors/gruvbox.vim ~/.vim/colors)

~/.config/nvim:
	ln -fs ~/dotfiles/nvim ~/.config/nvim

nvim: nvim-install nvim-plug-install nvim-check-and-backup nvim-config nvim-plugins-install

nvim-reinstall: nvim-clean nvim

nvim-plug-install:
	sh -c 'curl -fLo "$${XDG_DATA_HOME:-$$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim-plugins-install:
	nvim -R +PlugInstall +qall

# If there is ~./config/nvim not linked to ~/dotfiles - backup it
nvim-check-and-backup:
	test ! -d ~/.config/nvim || \
		((ls -1l ~/.config/nvim | grep ~/dotfiles/nvim/init.vim) || \
		mv ~/.config/nvim ~/.config/nvim-$(TEMP_DATE))

nvim-clean:
	test ! -d ~/.config/nvim || mv ~/.config/nvim ~/.config/nvim-$(shell date "+%F-%T")
	
nvim-config: ~/.config/nvim # ~/.vim/bundle/vundle

nvim-install:
	which neovim || brew install neovim

~/.irbrc:
	ln -fs ~/dotfiles/.irbrc ~/.irbrc
~/.rdebugrc:
	ln -fs ~/dotfiles/.rdebugrc ~/.rdebugrc

~/.ackrc:
	ln -fs ~/dotfiles/.ackrc ~/.ackrc

~/.ctags:
	ln -fs ~/dotfiles/.ctags ~/.ctags

~/.pryrc:
	ln -fs ~/dotfiles/.pryrc ~/.pryrc

~/.tmux.conf:
	ln -fs ~/dotfiles/.tmux.conf ~/.tmux.conf

~/.psqlrc:
	ln -fs ~/dotfiles/.psqlrc ~/.psqlrc

~/.gemrc:
	ln -fs ~/dotfiles/.gemrc ~/.gemrc

~/.agignore:
	ln -fs ~/dotfiles/.agignore ~/.agignore

etc: ~/.irbrc ~/.rdebugrc ~/.ackrc ~/.pryrc ~/.tmux.conf ~/.psqlrc ~/.gemrc

ag: ~/.agignore
	which ag || brew install ag

ghostty-configure:
	ghostty +show-config --default --docs | nvim

ghostty: ghostty-install ghostty-config

ghostty-install:
	which ghostty || brew install ghostty

backup-config:
	test -d ${CONFIG_PATH} && \
		(test -L ${CONFIG_PATH} && test -e ${MY_CONFIG_PATH} || mv ${CONFIG_PATH} ${CONFIG_PATH}-$(TEMP_DATE)) || \
		/bin/true

link-config: backup-config
	test ! -d ${CONFIG_PATH} && ln -s ${MY_CONFIG_PATH} ~/.config/

ghostty-config:
	$(MAKE) link-config CONFIG_PATH=~/.config/ghostty MY_CONFIG_PATH=~/dotfiles/ghostty

tide-configure:
	tide configure --auto --style=Lean --prompt_colors='True color' --show_time=No --lean_prompt_height='One line' --prompt_spacing=Compact --icons='Few icons' --transient=No

fish: fish-install fish-backup-config fish-config fisher

fish-install:
	which fish || sudo apt-get install fish

fish-config:
	ln -s ~/dotfiles/fish/conf.d ~/.config/fish/
	ln -s ~/dotfiles/fish/config.fish ~/.config/fish/

fish-backup-config:
	test ! -d ~/.config/fish/conf.d || mv ~/.config/fish/conf.d ~/.config/fish/conf.d-$(TEMP_DATE)
	test ! -f ~/.config/fish/config.fish || mv ~/.config/fish/config.fish ~/.config/fish/config.fish-$(TEMP_DATE)

fisher: fisher-install fisher-plugins

fisher-plugins:
	./scripts/install-fish-plugins.fish

fisher-install:
	./scripts/install-fisher.fish
