if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -g fish_greeting

fish_add_path ~/bin

# Added by `rbenv init` on Mon May 19 15:21:16 MSK 2025
status --is-interactive; and rbenv init - --no-rehash fish | source

# You must call it on initialization or listening to directory switching won't work
load_nvm > /dev/stderr
