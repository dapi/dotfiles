# export LANG=ru_RU.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8 # Почему-то она не установлена в office

## Path to your oh-my-zsh configuration.
echo -n 'Start oh-my-zsh: '
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/dotfiles/zsh_custom
# Nice default theme
#export ZSH_THEME="agnoster"
export ZSH_THEME="dapi-maran"
eval "$(direnv hook zsh)"
test -f ~/.local.zsh && source ~/.local.zsh
echo 'Done'


# Custom theme
test -f ~/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh && ~/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh

export EDITOR=vim
export PGOPTIONS='--client-min-messages=warning'

export TERM=xterm-256color #screen-256color

# На mac-е не зачем устанавливать PATH, а вот на ubuntu нужно
# export PATH=~/bin:~/.rbenv/bin:$PATH

unsetopt correct_all

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
# linux
if echo "$TERM_PROGRAM" | grep "Apple_Terminal\|iTerm.app" > /dev/null; then
  plugins=(ssh-agent nvm lein git git-extras rbenv capistrano brew brew-cask vundle rake-fast)
  ## NVM
  echo -n 'Start nvm: '
  export NVM_DIR=~/.nvm
  source $(brew --prefix nvm)/nvm.sh
  echo 'Done'

else
  plugins=(ssh-agent rails bundle nvm git git-extras rbenv capistrano ruby rake vundle emacs rake-fast)
fi

# Должен вызываться после plugins
source $ZSH/oh-my-zsh.sh

alias tmux='direnv exec / tmux'
alias rails='bundle exec rails'
alias rspec='bundle exec rspec'
alias rake='bundle exec rake'
alias cap='bundle exec cap'
alias m='bundle exec m'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -g ""'

alias v='vim $(fzf)'

if test -f ~/.tmux_auto; then
  if test -z "$TMUX" ; then
    /usr/local/bin/tmux attach && /usr/local/bin/tmux && echo "tmux failed to start"
  fi
fi

# export RBENV_ROOT=/usr/local/var/rbenv
# eval "$(rbenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
