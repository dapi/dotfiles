#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

pass() {
  printf 'ok - %s\n' "$1"
}

fail() {
  printf 'not ok - %s\n' "$1" >&2
  exit 1
}

legacy_refs="$(
  git grep -nE '\bnvm\b|\brbenv\b|NVM_DIR|RBENV_ROOT|ruby-build|\.nvmrc|\.ruby-version' \
    -- . ':(exclude)tests/mise-only.sh' || true
)"

if [ -n "$legacy_refs" ]; then
  printf '%s\n' "$legacy_refs" >&2
  fail "tracked files should not reference nvm or rbenv"
fi

if ! grep -q '^node = ' mise.toml; then
  fail "mise.toml should define a Node.js version"
fi

if ! grep -q '^ruby = ' mise.toml; then
  fail "mise.toml should define a Ruby version"
fi

pass "tracked files use mise without legacy nvm/rbenv references"
