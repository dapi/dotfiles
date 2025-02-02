if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -g fish_greeting

export PAGER=/opt/homebrew/bin/nvimpager
export MANPAGER=/opt/homebrew/bin/nvimpager
export TERM=xterm-256color
export KUBECONFIG=~/.kube/config:~/.kube/ovh-kubeconfig.yml

alias less=$PAGER
alias office="ssh office.brandymint.ru"

[ -n "$SSH_CONNECTION" ] && echo -e "\033]11;#1F2800\a"
