set -gx LESS -eiRMX
set -x PGOPTIONS '--client-min-messages=warning'
set -x EDITOR nvim
set -x PATH $PATH $HOME/.local/bin
set -gx PATH $PATH $HOME/.krew/bin

# nvimpager не умеет переходить в редактор по v как это делает less
#
#if [ `uname` = "Darwin" ]; then
    #set -x PAGER=/opt/homebrew/bin/nvimpager
    #set -x MANPAGER=/opt/homebrew/bin/nvimpager
#end
