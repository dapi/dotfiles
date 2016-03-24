# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/dotfiles/zsh_custom

eval "$(direnv hook zsh)"

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
if echo "$TERM_PROGRAM" | grep "Apple_Terminal\|iTerm.app" > /dev/null; then
  export NVM_DIR=~/.nvm
  . $(brew --prefix nvm)/nvm.sh
  plugins=(ssh-agent nvm lein git git-extras rbenv vagrant capistrano brew brew-cask vundle rake-fast)
else
  plugins=(ssh-agent nvm git git-extras rbenv vagrant capistrano ruby rake vundle emacs rake-fast)
fi

source $ZSH/oh-my-zsh.sh

test -f ~/.local.zsh && source ~/.local.zsh

# export LANG=ru_RU.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8 # Почему-то она не установлена в office

# test "$HOME" = '/Users/danil'
alias office='ssh office.icfdev.ru'
alias tmux='direnv exec / tmux'

# http://jetpackweb.com/blog/2009/09/23/pbcopy-in-ubuntu-command-line-clipboard/
# Simulate OSX's pbcopy and pbpaste on other platforms
if [ ! $(uname -s) = "Darwin" ]; then
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
  #alias pbcopy='xclip -selection clipboard'
  #alias pbpaste='xclip -selection clipboard -o'
fi

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -g ""'

alias v='vim $(fzf)'
