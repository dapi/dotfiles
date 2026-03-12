# AI agents, CLI tools, skills, and plugins

APPLIES:=$(APPLIES) agents agents-cli agents-skills agents-claude-plugins

# --- AI Agents ---

agents:
	npm install -g @anthropic-ai/claude-code
	npm install -g @openai/codex

# --- CLI tools used by agents ---

agents-cli:
	npm install -g @playwright/cli@latest
	npm install -g @dapi/tgcli
	npm install -g @dapi/docmost-cli
	npm install -g @googleworkspace/cli

# --- Skills for agents ---

agents-skills:
	npx skills add dapi/tgcli --skill tgcli --agent '*' -g -y
	npx skills add dapi/docmost-cli --skill docmost --agent '*' -g -y
	npx skills add googleworkspace/cli --skill google_workspace --agent '*' -g -y

# --- Claude Code plugins ---

CLAUDE_PLUGINS_MARKETPLACES = lackeyjb/playwright-skill dapi/claude-code-marketplace

CLAUDE_PLUGINS = \
	playwright-skill@playwright-skill \
	github-workflow@dapi \
	zellij-workflow@dapi \
	spec-reviewer@dapi \
	cluster-efficiency@dapi \
	doc-validate@dapi \
	media-upload@dapi \
	himalaya@dapi \
	task-router@dapi \
	pr-review-fix-loop@dapi

agents-claude-plugins:
	@for mp in $(CLAUDE_PLUGINS_MARKETPLACES); do \
		echo "Adding marketplace $$mp..."; \
		claude plugins marketplace add $$mp; \
	done
	@for plugin in $(CLAUDE_PLUGINS); do \
		echo "Installing plugin $$plugin..."; \
		claude plugins install $$plugin; \
	done
