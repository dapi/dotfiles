if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -g fish_greeting

export PAGER=/opt/homebrew/bin/nvimpager
export MANPAGER=/opt/homebrew/bin/nvimpager

alias less=$PAGER
alias office="ssh office.brandymint.ru"
