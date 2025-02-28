brew: brew-install brew-packages

brew-packages:
	brew install ag
	brew install direnv
	brew install --cask amneziavpn
	brew install pass
	brew install fzf
brew-install:
	which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
