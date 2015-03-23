#!/bin/bash

cd ~

test -f .irbrc || ln -s dotfiles/irbrc .irbrc
test -f .vimrc || ln -s dotfiles/.vimrc .vimrc
test -f .rdebugrc || ln -s dotfiles/rdebugrc .rdebugrc
test -f .ackrc || ln -s dotfiles/ackrc .ackrc
test -f .gitconfig || cp dotfiles/gitconfig .gitconfig
test -f .gitignore_global || ln -s dotfiles/gitignore_global .gitignore_global
test -f .ctags || ln -s dotfiles/ctags .ctags
test -f .pryrc || ln -s dotfiles/pryrc .pryrc

test -f .zshrc && mv -f .zshrc .zshrc.before_dotfiles
ln -s dotfiles/zshrc .zshrc

test -f .tmux.conf || ln -s dotfiles/tmux.conf .tmux.conf
