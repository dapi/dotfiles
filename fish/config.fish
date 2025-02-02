if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -g fish_greeting

fish_add_path ~/bin

[ -n "$SSH_CONNECTION" ] && echo -e "\033]11;#1F2800\a"
