.PHONY: test test-pre-commit test-agents-install

test: test-pre-commit test-agents-install

test-pre-commit:
	@bash tests/pre-commit.sh

test-agents-install:
	@bash tests/agents-install.sh
