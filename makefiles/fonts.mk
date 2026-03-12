APPLIES:=$(APPLIES) fonts

fonts: hack-nerd-font

hack-nerd-font:
	@echo "Install hack-nerd-font"
	@test -d ${HOME}/Library/Fonts && \
	ls -1 ${HOME}/Library/Fonts/*HackNerdFont* > /dev/null 2>&1 || \
		(which brew > /dev/null 2>&1 && brew install font-hack-nerd-font || echo "No brew to install fonts")

powerline-fonts:
	git clone https://github.com/powerline/fonts.git ./powerline-fonts
	(cd powerline-fonts; ./install.sh)
