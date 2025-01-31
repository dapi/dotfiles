## Deprecated in grep
unset GREP_OPTIONS

## Path to your oh-my-zsh configuration.
echo -n 'Start oh-my-zsh: '
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/dotfiles/zsh_custom
# Nice default theme
#export ZSH_THEME="agnoster"
export ZSH_THEME="dapi-maran"
# Custom theme
# test -f ~/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh && ~/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh

test -f ~/.zsh.local && source ~/.zsh.local

export EDITOR=nvim
export PGOPTIONS='--client-min-messages=warning'

# eval "$(direnv hook zsh)"
# eval "$(goenv init -)"

source "${ZDOTDIR:-${HOME}}/dotfiles/.zshrc-`uname`"

plugins=(autoupdate ssh-agent nvm bundler git git-extras rbenv capistrano direnv rake rails rake-fast docker-compose docker kubectl)

# Должен вызываться после plugins
source $ZSH/oh-my-zsh.sh
echo 'Plugins'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -g ""'

echo 'Done'

unsetopt correct_all

