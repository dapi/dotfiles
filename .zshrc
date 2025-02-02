## Path to your oh-my-zsh configuration.
echo -n 'Start oh-my-zsh: '
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/dotfiles/zsh_custom

export ZSH_THEME="dapi-maran"

test -f ~/.zsh.local && source ~/.zsh.local

source "${ZDOTDIR:-${HOME}}/dotfiles/.zshrc-`uname`"

plugins=(ssh-agent nvm git rbenv direnv rails docker-compose docker kubectl)

# Должен вызываться после plugins
source $ZSH/oh-my-zsh.sh

unsetopt correct_all

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -g ""'

alias -g vim=nvim
alias -g vi=nvim

export EDITOR=nvim
export PGOPTIONS='--client-min-messages=warning'

## Deprecated in grep
unset GREP_OPTIONS

export TERM=xterm-256color

# Created by `pipx` on 2025-02-02 18:43:53
export PATH="$PATH:/home/danil/.local/bin"
