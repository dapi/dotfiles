# Skip heavy initialization for non-interactive sessions and --help
if status --is-interactive

    # /opt/homebrew/opt/mise/bin/mise activate fish | source
    ~/.local/bin/mise activate fish | source # added by https://mise.run/fish

    # SSH keychain - reuse ssh-agent across sessions
    if type -q keychain
        keychain --eval --quiet -Q id_ed25519.priv 2>/dev/null | source
    end

    # GPG: tell pinentry which terminal to use (needed for zellij panes)
    set -gx GPG_TTY (tty)

    # Lazy-load Bugsnag proxy only when a matching command is executed.
    function __load_bugsnag_proxy_once --description 'Load BUGSNAG_HTTP_PROXY from pass once per shell'
        if set -q __bugsnag_proxy_loaded
            return
        end
        set -g __bugsnag_proxy_loaded 1

        if test (uname) != "Linux"
            return
        end
        if not type -q pass
            return
        end

        set -l bugsnag_proxy (pass show proxy/current 2>/dev/null)
        if test -n "$bugsnag_proxy"
            set -gx BUGSNAG_HTTP_PROXY $bugsnag_proxy
        end
    end

    #eval (zellij setup --generate-auto-start fish | string collect)
else
    # For non-interactive sessions, skip version managers entirely
    set -g fish_greeting
    exit 0
end

# Add basic paths if not already present
#fish_add_path /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin /usr/bin /bin /usr/sbin /sbin

# Add other paths
fish_add_path ~/.local/bin
fish_add_path ~/bin
fish_add_path ~/.opencode/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.bun/bin

# Always run claude in dangerously-skip-permissions mode
alias claude="command claude --dangerously-skip-permissions"
alias codex="codex --dangerously-bypass-approvals-and-sandbox --search"

# TODO сделать чтобы это было доступно только на macos
# Mount office2 sshfs
alias mount-office="~/bin/mount-office.sh"
alias mount-office2="~/bin/mount-office2.sh"
# The following snippet is meant to be used like this in your fish config:
#
if status is-interactive
#     # Configure auto-attach/exit to your likings (default is off).
# set ZELLIJ_AUTO_ATTACH true
#     # set ZELLIJ_AUTO_EXIT true
#     eval (zellij setup --generate-auto-start fish | string collect)
end
if not set -q ZELLIJ; and test (uname) != "Darwin"
    if test "$ZELLIJ_AUTO_ATTACH" = "true"
        zellij attach -c --index 0
    else
        zellij
    end

    if test "$ZELLIJ_AUTO_EXIT" = "true"
        kill $fish_pid
    end
end
