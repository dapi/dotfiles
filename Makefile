all: fonts git zsh terminal vim vundle nvm rbenv goenv ctags etc nvim ag

fonts:
	brew install font-hack-nerd-font
	git clone https://github.com/powerline/fonts.git
	(cd fonts; ./install.sh)

sshbg:
	curl https://github.com/fboender/sshbg/blob/855ade6b3c4f9f54ffb739aaf71a2e9baa8cf170/sshbg > ~/.bin/sshbg
	chmod a+x ~/.bin/sshbg

ctags: ctags-install ~/.ctags

ctags-install:
	which ctags || brew install ctags

brew:
	brew install nvimpager

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

ghostty-configure:
	ghostty +show-config --default --docs | nvim

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
		mv ~/.config/nvim ~/.config/nvim-$(shell date "+%F-%T"))

nvim-clean:
	test ! -d ~/.config/nvim || mv ~/.config/nvim ~/.config/nvim-$(shell date "+%F-%T")
	
nvim-config: ~/.config/nvim # ~/.vim/bundle/vundle

nvim-install:
	which nvim || brew install neovim

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

tide-configure:
	tide configure --auto --style=Lean --prompt_colors='True color' --show_time=No --lean_prompt_height='One line' --prompt_spacing=Compact --icons='Few icons' --transient=No

fish-config:
	ln -s ~/dotfiles/fish/conf.d/ ~/.config/fish/
	ln -s ~/dotfiles/fish/config.fish ~/.config/fish/

ghostty-config:
	ln -s ~/dotfiles/ghostty ~/.config/

fisher: fisher-install fisher-plugins

fisher-plugins:
	fisher install jorgebucaran/autopair.fish
	fisher install jorgebucaran/spark.fish
	fisher install rbenv/fish-rbenv
	fisher install jorgebucaran/nvm.fish
	fisher install IlanCosman/tide 
	fisher install danhper/fish-ssh-agent
	fisher install halostatue/fish-direnv

fisher-install:
	which fisher || \
		(curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher)
