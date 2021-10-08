# export LANG=ru_RU.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8 # Почему-то она не установлена в office

## Deprecated in grep
unset GREP_OPTIONS

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
export GOPATH=~/go
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
export PATH=~/bin:$PATH
# export ANDROID_SDK_ROOT=/opt/android-sdk-linux/
eval "$(goenv init -)"
unsetopt correct_all

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

BUNDLED_COMMANDS=(rubocop cap rake rails rspec)
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
# linux
plugins=(ssh-agent nvm bundler git git-extras rbenv capistrano rake rails rake-fast)

if echo "$TERM_PROGRAM" | grep "Apple_Terminal\|iTerm.app" > /dev/null; then
  plugins+=(brew brew-cask)
else
  # Add nothing
  # plugins+=()
fi

# Должен вызываться после plugins
source $ZSH/oh-my-zsh.sh
# ###########
# TMUX section
# ###########

alias tmux='direnv exec / tmux'

if test -f ~/.tmux_auto; then
  if test -z "$TMUX" ; then
    /usr/local/bin/tmux attach && /usr/local/bin/tmux && echo "tmux failed to start"
  fi
fi

# ###########
# FZF section
# ###########

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -g ""'

alias v='vim $(fzf-tmux)'

alias bitcoin-cli='docker exec -it bitcoind-node bitcoin-cli'

# ###########
# NVM section
# ###########

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Calling nvm use automatically in a directory with a .nvmrc file
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
