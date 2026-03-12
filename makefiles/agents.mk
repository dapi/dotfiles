# AI agents, CLI tools, skills, and plugins

BLUE := \033[0;34m
GREEN := \033[0;32m
NC := \033[0m

NPM ?= mise exec -- npm
CLAUDE ?= mise exec -- claude
SKILLS_NPX ?= mise exec -- npx
SKILLS ?= $(SKILLS_NPX) skills
DOTFILES_ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))/..)
AGENTS_LOCK_FILE := $(DOTFILES_ROOT)/.skill-lock.json
AGENTS_TARGETS := codex claude-code
AGENTS_SKILLS_AGENT_FLAGS := $(foreach agent,$(AGENTS_TARGETS),-a $(agent))

.PHONY: ai agents-install agents agents-cli agents-skills agents-claude-plugins
.PHONY: agents-skills-install agents-skills-update agents-skills-list agents-skills-add
.PHONY: agents-skills-check-npx agents-skills-check-jq

ai: bootstrap
	@$(MAKE) package PACKAGE=jq
	@$(MAKE) agents-install

agents-install: agents agents-cli agents-skills agents-claude-plugins

# --- AI Agents ---

agents:
	@$(NPM) install -g @anthropic-ai/claude-code
	@$(NPM) install -g @openai/codex

# --- CLI tools used by agents ---

agents-cli:
	@$(NPM) install -g @playwright/cli@latest
	@$(NPM) install -g @dapi/tgcli
	@$(NPM) install -g @dapi/docmost-cli
	@$(NPM) install -g @googleworkspace/cli

# --- Skills for agents ---

agents-skills: agents-skills-install

agents-skills-check-npx:
	@$(SKILLS_NPX) --version >/dev/null 2>&1 || (echo "❌ npx not available via mise. Run 'make ai' after bootstrap installs Node.js." && exit 1)

agents-skills-check-jq:
	@command -v jq >/dev/null 2>&1 || (echo "❌ jq not found. Run 'make ai' so jq is installed before parsing the skills manifest." && exit 1)

agents-skills-install: agents-skills-check-npx agents-skills-check-jq
	@echo "$(BLUE)📦 Installing skills from .skill-lock.json...$(NC)"
	@set -e; \
	entries_file="$$(mktemp "$${TMPDIR:-/tmp}/agents-skills-install.XXXXXX")"; \
	trap 'rm -f "$$entries_file"' EXIT HUP INT TERM; \
	jq -r '.skills | to_entries[] | [.key, .value.source] | @tsv' "$(AGENTS_LOCK_FILE)" > "$$entries_file"; \
	while IFS=$$'\t' read -r skill source; do \
		if [ -z "$$skill" ]; then \
			continue; \
		fi; \
		echo "  📥 Installing $$skill from $$source"; \
		$(SKILLS) add "$$source" -g $(AGENTS_SKILLS_AGENT_FLAGS) -y --skill "$$skill"; \
	done < "$$entries_file"

agents-skills-update: agents-skills-check-npx agents-skills-check-jq
	@echo "$(BLUE)🔄 Refreshing tracked skills from .skill-lock.json...$(NC)"
	@set -e; \
	entries_file="$$(mktemp "$${TMPDIR:-/tmp}/agents-skills-update.XXXXXX")"; \
	trap 'rm -f "$$entries_file"' EXIT HUP INT TERM; \
	jq -r '.skills | to_entries[] | [.key, .value.source] | @tsv' "$(AGENTS_LOCK_FILE)" > "$$entries_file"; \
	while IFS=$$'\t' read -r skill source; do \
		if [ -z "$$skill" ]; then \
			continue; \
		fi; \
		echo "  🔄 Refreshing $$skill from $$source"; \
		$(SKILLS) add "$$source" -g $(AGENTS_SKILLS_AGENT_FLAGS) -y --skill "$$skill"; \
	done < "$$entries_file"

agents-skills-list: agents-skills-check-jq
	@echo "$(BLUE)📋 Tracked skills from .skill-lock.json:$(NC)"
	@jq -r '.skills | to_entries[] | "  \(.key) (\(.value.source))"' "$(AGENTS_LOCK_FILE)"

agents-skills-add: agents-skills-check-jq
ifndef SOURCE
	$(error Use 'make agents-skills-add SOURCE=owner/repo SKILL=name')
endif
ifndef SKILL
	$(error Use 'make agents-skills-add SOURCE=owner/repo SKILL=name')
endif
	@echo "$(BLUE)➕ Adding $(SKILL) to tracked .skill-lock.json...$(NC)"
	@set -e; \
	updated_manifest="$$(mktemp "$${TMPDIR:-/tmp}/agents-skills-manifest.XXXXXX")"; \
	trap 'rm -f "$$updated_manifest"' EXIT HUP INT TERM; \
	jq --arg skill "$(SKILL)" --arg source "$(SOURCE)" ' \
		.skills = (.skills // {}) \
		| .skills[$$skill] = {source: $$source} \
	' "$(AGENTS_LOCK_FILE)" > "$$updated_manifest"; \
	mv "$$updated_manifest" "$(AGENTS_LOCK_FILE)"; \
	echo "$(GREEN)✓ Updated tracked .skill-lock.json for $(SKILL)$(NC)"; \
	echo "Run 'make agents-skills-install' or 'make ai' to install the new skill."

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
		$(CLAUDE) plugins marketplace add $$mp; \
	done
	@for plugin in $(CLAUDE_PLUGINS); do \
		echo "Installing plugin $$plugin..."; \
		$(CLAUDE) plugins install $$plugin; \
	done
