fonts: hack-nerd-font

hack-nerd-font:
	which brew && brew install font-hack-nerd-font || echo "No brew to install fonts"

powerline-fonts:
	git clone https://github.com/powerline/fonts.git ./powerline-fonts
	(cd powerline-fonts; ./install.sh)
