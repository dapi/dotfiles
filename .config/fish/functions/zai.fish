function __zai_env --description 'Set up environment variables for ZAI API'
		set -gx ANTHROPIC_AUTH_TOKEN (pass show zai)
		set -gx ANTHROPIC_BASE_URL "https://api.z.ai/api/anthropic"
		set -gx ANTHROPIC_DEFAULT_HAIKU_MODEL "glm-4.5-air"
		set -gx ANTHROPIC_DEFAULT_SONNET_MODEL "glm-4.6"
		set -gx ANTHROPIC_DEFAULT_OPUS_MODEL "glm-4.6"
		set -gx ANTHROPIC_MODEL "glm-4.6"
		set -gx API_TIMEOUT_MS "3000000"
end

function zai --description 'Run claude with ZAI configuration'
		__zai_env
		claude $argv
end
