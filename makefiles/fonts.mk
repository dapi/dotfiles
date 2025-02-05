fonts: hack-nerd-font

hack-nerd-font:
	@echo "Install hack-nerd-font"
	@test -d /home/danil/Library/Fonts && \
	ls -1 ~/Library/Fonts/*HackNerdFont* /dev/null || \
		(which brew && brew install font-hack-nerd-font || echo "No brew to install fonts")

powerline-fonts:
	git clone https://github.com/powerline/fonts.git ./powerline-fonts
	(cd powerline-fonts; ./install.sh)
