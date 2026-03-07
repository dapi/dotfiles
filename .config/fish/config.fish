# Non-interactive sessions: keep startup minimal.
if not status --is-interactive
    set -g fish_greeting
    exit 0
end

# User snippets are loaded by fish from conf.d/.
zoxide init fish | source
