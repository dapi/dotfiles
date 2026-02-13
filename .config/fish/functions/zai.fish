function zai --description 'Run claude with ZAI configuration'
    env ANTHROPIC_AUTH_TOKEN=(pass show zai) \
        ANTHROPIC_BASE_URL="https://api.z.ai/api/anthropic" \
        ANTHROPIC_DEFAULT_HAIKU_MODEL="glm-4.5-air" \
        ANTHROPIC_DEFAULT_SONNET_MODEL="glm-4.7" \
        ANTHROPIC_DEFAULT_OPUS_MODEL="glm-4.7" \
        ANTHROPIC_MODEL="glm-4.7" \
        API_TIMEOUT_MS="3000000" \
        claude $argv
end
