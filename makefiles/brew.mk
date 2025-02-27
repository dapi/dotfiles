brew: brew-install brew-packages

brew-packages:
	brew install ag
brew-install:
	which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
