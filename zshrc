# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/dotfiles/zsh_custom

# Custom theme
export ZSH_THEME="dapi-maran"
test -f ~/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh && ~/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh

export EDITOR=vim
# Nice default theme
#export ZSH_THEME="agnoster"

export TERM=xterm-256color
#screen-256color

# На mac-е не зачем устанавливать PATH
#export PATH=/usr/local/bin:~/bin:$PATH

#export PATH=$PATH:/usr/local/mysql/bin/
#export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

# http://snupt.com/?p=1908
#export NODE_PATH=/usr/local/share/npm/lib/node_modules
#export PATH=/usr/local/share/npm/bin:$PATH

#export PATH=/usr/local/opt/android-sdk/tools:$PATH
#export ANDROID_HOME=/usr/local/opt/android-sdk

unsetopt correct_all

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
# linux
plugins=(git git-extras rbenv vagrant ruby rake vundle rake-fast)
# mac
#plugins=(git git-extras rbenv vagrant brew brew-cask vundle rake-fast)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

# test "$HOME" = '/Users/danil'
alias office='ssh office.icfdev.ru'

# Customize to your needs...
#
# Другой способ:
# http://stackoverflow.com/questions/19533528/installing-java-on-os-x-10-9-mavericks
#export JAVA_HOME=/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/
