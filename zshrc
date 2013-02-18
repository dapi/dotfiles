[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

export PATH="$HOME/bin:$PATH"
export EDITOR=/usr/local/bin/vim
export PGOPTIONS='--client-min-messages=warning'
#eval "$(rbenv init -)"
#

export LANG=ru_RU.UTF-8

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="dapi-maran"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(rails3 ruby git git-flow gem ssh-agent)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

#export PS1="%{$fg_bold[red]%}ci➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}"

alias c='bundle exec rails c'

unsetopt correct_all

# Define Vim wrappers which unsets GEM_HOME and GEM_PATH before
# invoking vim and all known aliases
#
# @author Wael Nasreddine <wael.nasreddine@gmail.com>
function define_vim_wrappers()
{
  vim_commands=(
    eview evim gview gvim gvimdiff gvimtutor rgview
    rgvim rview rvim vim vimdiff vimtutor xxd mvim
    vi git
  )

  for cmd in ${vim_commands[@]}; do
    cmd_path=`/usr/bin/env which -a "${cmd}" 2>/dev/null | grep '^/'`
    if [ -x "${cmd_path}" ]; then
      eval "function ${cmd} () { (unset GEM_HOME; unset GEM_PATH; $cmd_path \$@) }"
    fi
  done
}

# define_vim_wrappers

if echo $TERM | grep screen > /dev/null; then
else
  session='Castor'
  #((tmux has-session -t $session && tmux attach-session -t $session) || (tmux new-session -s $session) ) && exit 0
  tmux attach && exit 0
  echo "tmux failed to start"
fi

#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
