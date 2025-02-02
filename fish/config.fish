if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -g fish_greeting

if [ `uname` = "Darwin" ]; then
    export PAGER=/opt/homebrew/bin/nvimpager
    export MANPAGER=/opt/homebrew/bin/nvimpager
end

export TERM=xterm-256color
export KUBECONFIG=~/.kube/config:~/.kube/ovh-kubeconfig.yml

fish_add_path ~/bin

# set -gx LESS -eiRMX
alias less=$PAGER
alias office="ssh office.brandymint.ru"
alias h='helmfile --skip-deps --no-color'

[ -n "$SSH_CONNECTION" ] && echo -e "\033]11;#1F2800\a"
