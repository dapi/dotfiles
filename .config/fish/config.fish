# Skip heavy initialization for non-interactive sessions and --help
if status --is-interactive

    # Включить CSI u для Ghostty/Kitty/WezTerm через SSH
    printf '\e[>1u'

    # Выключить при выходе
    function __cleanup_csi_u --on-event fish_exit
        printf '\e[<u'
    end

    # /opt/homebrew/opt/mise/bin/mise activate fish | source
    ~/.local/bin/mise activate fish | source # added by https://mise.run/fish

    # SSH keychain - reuse ssh-agent across sessions
    if type -q keychain
        keychain --eval --quiet -Q id_ed25519.priv 2>/dev/null | source
    end

    # Bugsnag proxy for Linux
    if test (uname) = "Linux"
        set -gx BUGSNAG_HTTP_PROXY (pass show proxy/current)
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
