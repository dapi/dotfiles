#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEST_REPOS=()

cleanup() {
  if [ "${#TEST_REPOS[@]}" -gt 0 ]; then
    rm -rf "${TEST_REPOS[@]}"
  fi
}

trap cleanup EXIT

pass() {
  printf 'ok - %s\n' "$1"
}

fail() {
  printf 'not ok - %s\n' "$1" >&2
  exit 1
}

assert_contains() {
  local needle="$1"
  local haystack="$2"
  local message="$3"

  if [[ "$haystack" != *"$needle"* ]]; then
    fail "$message"
  fi
}

assert_not_contains() {
  local needle="$1"
  local haystack="$2"
  local message="$3"

  if [[ "$haystack" == *"$needle"* ]]; then
    fail "$message"
  fi
}

setup_repo_copy() {
  local repo_copy
  repo_copy="$(mktemp -d "${TMPDIR:-/tmp}/dotfiles-agents-install.XXXXXX")"
  TEST_REPOS+=("$repo_copy")
  rsync -a --exclude '.git' "$repo_root/" "$repo_copy/"
  printf '%s\n' "$repo_copy"
}

test_default_make_does_not_include_ai_workflow() {
  local repo_copy output
  repo_copy="$(setup_repo_copy)"

  output="$(cd "$repo_copy" && make -n)"

  assert_not_contains "Installing curated skills" "$output" "default make should not install curated skills"
  assert_not_contains "@anthropic-ai/claude-code" "$output" "default make should not install AI agents"
  assert_contains "Run 'make ai' to install AI agents, CLI tools, plugins, and curated skills." "$output" "default make should remind about the separate AI bootstrap"
  pass "default make excludes the AI bootstrap workflow"
}

test_ai_target_includes_curated_skills_install() {
  local repo_copy output
  repo_copy="$(setup_repo_copy)"

  output="$(cd "$repo_copy" && make -n ai)"

  assert_contains "Installing curated skills" "$output" "ai target should install curated skills"
  assert_contains "mise exec -- npx skills add dapi/tgcli --skill tgcli -g -a codex -a claude-code -y" "$output" "ai target should install tgcli only for supported agents"
  assert_contains "@openai/codex" "$output" "ai target should install Codex"
  assert_not_contains "PACKAGE=jq" "$output" "ai target should not depend on jq anymore"
  pass "ai target bootstraps agents, tools, and curated skills"
}

test_install_uses_supported_agents_only() {
  local repo_copy output
  repo_copy="$(setup_repo_copy)"

  output="$(cd "$repo_copy" && make -n agents-skills-install)"

  assert_contains "-a codex -a claude-code" "$output" "install target should scope skills to supported agents"
  assert_not_contains "--agent '*'" "$output" "install target should not target every available agent"
  pass "agents-skills-install targets only codex and claude-code"
}

test_install_fails_when_any_skill_install_fails() {
  local repo_copy output status
  repo_copy="$(setup_repo_copy)"

  cat > "$repo_copy/test-skills.sh" <<'SH'
#!/bin/sh
case " $* " in
  *" --skill docmost "*) exit 1 ;;
  *) exit 0 ;;
esac
SH
  chmod +x "$repo_copy/test-skills.sh"

  set +e
  output="$(cd "$repo_copy" && make agents-skills-install SKILLS="$repo_copy/test-skills.sh" SKILLS_NPX=true 2>&1)"
  status=$?
  set -e

  [ "$status" -ne 0 ] || fail "agents-skills-install should fail when any skill install fails"
  assert_contains "Installing docmost from dapi/docmost-cli" "$output" "install target should attempt the failing skill"
  pass "agents-skills-install propagates install failures"
}

test_list_outputs_curated_skills() {
  local repo_copy output
  repo_copy="$(setup_repo_copy)"

  output="$(cd "$repo_copy" && make agents-skills-list)"

  assert_contains "tgcli (dapi/tgcli)" "$output" "list target should include tgcli"
  assert_contains "docmost (dapi/docmost-cli)" "$output" "list target should include docmost"
  assert_contains "gws-docs (googleworkspace/cli)" "$output" "list target should include grouped google workspace skills"
  pass "agents-skills-list prints the curated skills list"
}

test_default_make_does_not_include_ai_workflow
test_ai_target_includes_curated_skills_install
test_install_uses_supported_agents_only
test_install_fails_when_any_skill_install_fails
test_list_outputs_curated_skills
