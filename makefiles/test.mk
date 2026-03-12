.PHONY: test test-pre-commit

test: test-pre-commit

test-pre-commit:
	@bash tests/pre-commit.sh
