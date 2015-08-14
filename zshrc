# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/dotfiles/zsh_custom

# Custom theme
export ZSH_THEME="dapi-maran"
test -f ~/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh && ~/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh

export EDITOR=vim
export PGOPTIONS='--client-min-messages=warning'
# Nice default theme
#export ZSH_THEME="agnoster"

export TERM=xterm-256color
#screen-256color

# На mac-е не зачем устанавливать PATH, а вот на ubuntu нужно
export PATH=~/bin:$PATH

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
if echo "$TERM_PROGRAM" | grep Apple_Terminal > /dev/null; then
  plugins=(ssh-agent lein git git-extras rbenv vagrant capistrano brew brew-cask vundle emacs rake-fast)
else
  plugins=(git git-extras rbenv nvm vagrant capistrano ruby rake vundle emacs rake-fast)
fi

source $ZSH/oh-my-zsh.sh

test -f ~/.local.zsh && source ~/.local.zsh

#export LANG=ru_RU.UTF-8

# test "$HOME" = '/Users/danil'
alias office='ssh office.icfdev.ru'

if test -f ~/.tmux_auto; then
  if test -z "$TMUX" ; then
    /usr/local/bin/tmux attach && /usr/local/bin/tmux && echo "tmux failed to start"
  fi
fi

# Customize to your needs...
#
# Другой способ:
# http://stackoverflow.com/questions/19533528/installing-java-on-os-x-10-9-mavericks
#export JAVA_HOME=/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/
