DOTFILES:=${DOTFILES} ~/.irbrc ~/.rdebugrc ~/.pryrc ~/.gemrc 
APPLIES:=$(APPLIES) rbenv

rbenv: ~/.rbenv ~/.rbenv/plugins/ruby-build

~/.rbenv:
	git clone https://github.com/rbenv/rbenv.git ~/.rbenv

~/.rbenv/plugins/ruby-build:
	git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
