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
	npx skills add googleworkspace/cli --skill gws-docs --agent '*' -g -y
	npx skills add googleworkspace/cli --skill gws-docs-write --agent '*' -g -y
	npx skills add googleworkspace/cli --skill gws-calendar --agent '*' -g -y
	npx skills add googleworkspace/cli --skill gws-calendar-agenda --agent '*' -g -y
	npx skills add googleworkspace/cli --skill gws-calendar-insert --agent '*' -g -y
	npx skills add googleworkspace/cli --skill gws-gmail --agent '*' -g -y
	npx skills add googleworkspace/cli --skill gws-gmail-send --agent '*' -g -y
	npx skills add googleworkspace/cli --skill gws-gmail-reply --agent '*' -g -y
	npx skills add googleworkspace/cli --skill gws-gmail-reply-all --agent '*' -g -y
	npx skills add googleworkspace/cli --skill gws-gmail-forward --agent '*' -g -y
	npx skills add googleworkspace/cli --skill gws-gmail-triage --agent '*' -g -y
	npx skills add googleworkspace/cli --skill gws-drive --agent '*' -g -y
	npx skills add googleworkspace/cli --skill gws-drive-upload --agent '*' -g -y
	npx skills add googleworkspace/cli --skill gws-sheets --agent '*' -g -y
	npx skills add googleworkspace/cli --skill gws-tasks --agent '*' -g -y
	npx skills add googleworkspace/cli --skill gws-meet --agent '*' -g -y

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
