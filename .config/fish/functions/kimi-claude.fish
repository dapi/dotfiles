function kimi-claude
	env ANTHROPIC_AUTH_TOKEN=$(pass show kimi) \
	ANTHROPIC_BASE_URL=https://api.moonshot.ai/anthropic \
	ANTHROPIC_MODEL=kimi-k2-thinking \
	ANTHROPIC_SMALL_FAST_MODEL=kimi-latest \
	claude $argv
end
