# Avoid extra config.fish work for non-interactive sessions.
if not status --is-interactive
    set -g fish_greeting
    exit 0
end

# User snippets are loaded by fish from conf.d/.

# The next line updates PATH for the Google Cloud SDK.
if test -f "$HOME/google-cloud-sdk/path.fish.inc"
    source "$HOME/google-cloud-sdk/path.fish.inc"
end
# zelda-wrappers
fish_add_path -p ~/.local/bin/zelda

# macOS-only paths
if test (uname) = Darwin
    fish_add_path /Applications/Obsidian.app/Contents/MacOS
    set -gx CLOUDSDK_PYTHON /opt/homebrew/bin/python3
end
