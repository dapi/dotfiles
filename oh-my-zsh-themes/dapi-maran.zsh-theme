# Theme with full path names and hostname
# Handy if you work on different servers all the time;
#
autoload -U colors && colors
 
autoload -Uz vcs_info
 
zstyle ':vcs_info:*' stagedstr '%F{green}●'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn

#precmd () {
#     if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
#         zstyle ':vcs_info:*' formats ' [%b%c%u%B%F{green}]'
#     } else {
#         zstyle ':vcs_info:*' formats ' [%b%c%u%B%F{red}●%F{green}]'
#     }
# 
#     vcs_info
#}
 
setopt prompt_subst

PROMPT='%{$fg[yellow]%}%n@%M:%{$reset_color%}%~$(git_prompt_info)%(!.#.$) '

ZSH_THEME_GIT_PROMPT_PREFIX="%F{green}("
#ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
