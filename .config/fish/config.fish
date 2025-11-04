# Skip heavy initialization for non-interactive sessions and --help
if status --is-interactive
    # /opt/homebrew/opt/mise/bin/mise activate fish | source
    /home/danil/.local/bin/mise activate fish | source # added by https://mise.run/fish
else
    # For non-interactive sessions, skip version managers entirely
    set -g fish_greeting
    fish_add_path ~/bin
    fish_add_path /Users/danil/.opencode/bin
    exit 0
end

# Add basic paths if not already present
#fish_add_path /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin /usr/bin /bin /usr/sbin /sbin

# Add other paths
fish_add_path ~/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
