# Non-interactive sessions: keep startup minimal.
if not status --is-interactive
    set -g fish_greeting
    exit 0
end

# Interactive snippets are loaded from config.d in lexical order.
set -l user_configd ~/.config/fish/config.d
if test -d $user_configd
    for f in (find -L $user_configd -mindepth 1 -maxdepth 1 -type f -name '*.fish' | sort)
        source $f
    end
end
