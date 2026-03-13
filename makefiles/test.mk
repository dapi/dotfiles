.PHONY: test test-pre-commit test-agents-install test-mise-only

test: test-pre-commit test-agents-install test-mise-only

test-pre-commit:
	@bash tests/pre-commit.sh

test-agents-install:
	@bash tests/agents-install.sh

test-mise-only:
	@bash tests/mise-only.sh
