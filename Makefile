all: fonts git zsh terminal vim vundle nvm rbenv goenv ctags etc nvim ag

fonts:
	brew install font-hack-nerd-font
	git clone https://github.com/powerline/fonts.git
	(cd fonts; ./install.sh)

ctags: ctags-install ~/.ctags

ctags-install:
	which ctags || brew install ctags

git: git-install ~/.gitconfig ~/.gitignore_global

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

~/.config/nvim:
	ln -fs ~/dotfiles/nvim ~/.config/nvim

~/.vimrc:
	ln -fs ~/dotfiles/.vimrc ~/.vimrc

vim: vim-install ~/.vimrc ~/.vim/bundle/vundle
vim-install:
	which vim || (brew install vim && vim -R +PluginInstall +qall)

nvim: nvim-install nvim-config nvim-plugins

nvim-reinstall: nvim-clean nvim

vim-colors:
	test -f ~/.vim/colors || (mkdir ~/.vim/colors && cp ~/.vim/bundle/gruvbox/colors/gruvbox.vim ~/.vim/colors)

nvim-plugins:
	nvim -R +PluginInstall +qall

nvim-clean:
	test ! -d ~/.config/nvim || mv ~/.config/nvim ~/.config/nvim-$(shell date "+%F-%T")
	
nvim-config: ~/.config/nvim ~/.vim/bundle/vundle

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
