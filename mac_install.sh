#!/bin/bash

test -f .irbrc && ln -s dotfiles/irbrc .irbrc
test -f .rdebugrc && ln -s dotfiles/rdebugrc .rdebugrc
test -f .ackrc && ln -s dotfiles/ackrc .ackrc
test -f .gitconfig && cp dotfiles/gitconfig .gitconfig
test -f .gitignore_global && ln -s dotfiles/gitignore_global .gitignore_global
#test -f .zshrc && ln -s dotfiles/zshrc.mac .zshrc
# install oh-my-zsh and patch .zshrc
