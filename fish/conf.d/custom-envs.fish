set -gx LESS -eiRMX
set -x KUBECONFIG ~/.kube/config:~/.kube/ovh-kubeconfig.yml
set -x PATH $PATH ~/.local/bin
set -x PGOPTIONS '--client-min-messages=warning'
set -x EDITOR nvim

# nvimpager не умеет переходить в редактор по v как это делает less
#
#if [ `uname` = "Darwin" ]; then
    #set -x PAGER=/opt/homebrew/bin/nvimpager
    #set -x MANPAGER=/opt/homebrew/bin/nvimpager
#end
