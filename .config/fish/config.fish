# Skip heavy initialization for non-interactive sessions and --help
if status --is-interactive
    # /opt/homebrew/opt/mise/bin/mise activate fish | source
    {$HOME}/.local/bin/mise activate fish | source # added by https://mise.run/fish
else
    # For non-interactive sessions, skip version managers entirely
    set -g fish_greeting
    fish_add_path ~/bin
    fish_add_path ~/.opencode/bin
    exit 0
end

function zai
    env ANTHROPIC_AUTH_TOKEN=$(pass show zai) \
        ANTHROPIC_BASE_URL="https://api.z.ai/api/anthropic" \
        ANTHROPIC_DEFAULT_HAIKU_MODEL="glm-4.5-air" \
        ANTHROPIC_DEFAULT_SONNET_MODEL="glm-4.6" \
        ANTHROPIC_DEFAULT_OPUS_MODEL="glm-4.6" \
        ANTHROPIC_MODEL="glm-4.6" \
        claude $argv
end

function kimi
	env ANTHROPIC_AUTH_TOKEN=$(pass show kimi) \
	ANTHROPIC_BASE_URL=https://api.moonshot.ai/anthropic \
	ANTHROPIC_MODEL=kimi-k2-thinking \
	ANTHROPIC_SMALL_FAST_MODEL=kimi-latest \
	claude $argv
end

# Add basic paths if not already present
#fish_add_path /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin /usr/bin /bin /usr/sbin /sbin

# Add other paths
fish_add_path ~/bin
