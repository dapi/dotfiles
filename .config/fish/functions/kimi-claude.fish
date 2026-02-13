function kimi-claude
	env ANTHROPIC_AUTH_TOKEN=$(pass show kimi) \
		ANTHROPIC_BASE_URL=https://api.kimi.com/coding/ \
	claude $argv
	# ANTHROPIC_MODEL=kimi-k2-thinking \
	# ANTHROPIC_SMALL_FAST_MODEL=kimi-latest \
end
