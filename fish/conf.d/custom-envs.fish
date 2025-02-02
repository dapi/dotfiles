if [ `uname` = "Darwin" ]; then
    set -x PAGER=/opt/homebrew/bin/nvimpager
    set -x MANPAGER=/opt/homebrew/bin/nvimpager
end

# set -gx LESS -eiRMX
set -x TERM xterm-256color
set -x KUBECONFIG ~/.kube/config:~/.kube/ovh-kubeconfig.yml
