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

  assert_not_contains "Installing skills from .skill-lock.json" "$output" "default make should not install tracked skills"
  assert_not_contains "@anthropic-ai/claude-code" "$output" "default make should not install AI agents"
  pass "default make excludes the AI bootstrap workflow"
}

test_ai_target_includes_curated_skills_install() {
  local repo_copy output
  repo_copy="$(setup_repo_copy)"

  output="$(cd "$repo_copy" && make -n ai)"

  assert_contains 'make package PACKAGE=jq' "$output" "ai target should install jq before parsing the skills manifest"
  assert_contains "Installing skills from .skill-lock.json" "$output" "ai target should install tracked skills"
  assert_contains "mise exec -- npx skills" "$output" "ai target should invoke the skills CLI through mise"
  assert_contains "@openai/codex" "$output" "ai target should install Codex"
  pass "ai target bootstraps agents, tools, and tracked skills"
}

test_install_reads_tracked_manifest() {
  local repo_copy output
  repo_copy="$(setup_repo_copy)"

  output="$(cd "$repo_copy" && make agents-skills-install SKILLS=true SKILLS_NPX=true)"

  assert_contains "Installing docmost from dapi/docmost-cli" "$output" "install target should read the tracked skill manifest"
  assert_contains "Installing tgcli from dapi/tgcli" "$output" "install target should iterate through tracked skills"
  pass "agents-skills-install reads the repo-owned manifest"
}

test_install_fails_when_any_skill_install_fails() {
  local repo_copy output status
  repo_copy="$(setup_repo_copy)"

  cat > "$repo_copy/.skill-lock.json" <<'JSON'
{
  "skills": {
    "docmost": {
      "source": "dapi/docmost-cli"
    },
    "tgcli": {
      "source": "dapi/tgcli"
    }
  }
}
JSON

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

test_add_updates_tracked_manifest_only() {
  local repo_copy output resulting_skills resulting_source
  repo_copy="$(setup_repo_copy)"

  cat > "$repo_copy/.skill-lock.json" <<'JSON'
{
  "skills": {
    "docmost": {
      "source": "dapi/docmost-cli"
    }
  }
}
JSON

  output="$(cd "$repo_copy" && make agents-skills-add SOURCE=microsoft/playwright-cli SKILL=playwright-cli)"
  resulting_skills="$(jq -r '.skills | keys[]' "$repo_copy/.skill-lock.json")"
  resulting_source="$(jq -r '.skills["playwright-cli"].source' "$repo_copy/.skill-lock.json")"

  assert_contains "Updated tracked .skill-lock.json for playwright-cli" "$output" "agents-skills-add should report the manifest update"
  assert_contains "docmost" "$resulting_skills" "existing curated skills should remain in the tracked manifest"
  assert_contains "playwright-cli" "$resulting_skills" "requested skill should be added to the tracked manifest"
  assert_contains "microsoft/playwright-cli" "$resulting_source" "requested skill source should be written into the tracked manifest"
  pass "agents-skills-add updates only the repo-owned manifest"
}

test_default_make_does_not_include_ai_workflow
test_ai_target_includes_curated_skills_install
test_install_reads_tracked_manifest
test_install_fails_when_any_skill_install_fails
test_add_updates_tracked_manifest_only
