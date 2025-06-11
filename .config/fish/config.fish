set -g fish_greeting

fish_add_path ~/bin

# Added by `rbenv init` on Mon May 19 15:21:16 MSK 2025
status --is-interactive; and rbenv init - --no-rehash fish | source

# You must call it on initialization or listening to directory switching won't work
load_nvm > /dev/stderr

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths

# pyenv
pyenv init - fish | source
