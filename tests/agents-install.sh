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

test_root_target_installs_into_runtime_directory() {
  local repo_copy test_home output
  repo_copy="$(setup_repo_copy)"
  test_home="$repo_copy/test-home"

  output="$(cd "$repo_copy" && HOME="$test_home" make agents-skills-install SKILLS=true SKILLS_NPX=true)"

  [ -d "$test_home/.agents" ] || fail "agents-skills-install should prepare the skills global state directory"
  assert_contains "Installing docmost from dapi/docmost-cli" "$output" "install target should read the tracked skill manifest"
  assert_contains "Installing tgcli from dapi/tgcli" "$output" "install target should iterate through tracked skills"
  pass "root agents-skills-install target uses skills global state without exposing its path"
}

test_apply_includes_agents_install() {
  local repo_copy test_home output
  repo_copy="$(setup_repo_copy)"
  test_home="$repo_copy/test-home"

  output="$(cd "$repo_copy" && HOME="$test_home" make -n apply)"

  assert_contains "Installing skills from .skill-lock.json" "$output" "main apply workflow should include agent skills installation"
  assert_contains ".skill-lock.json" "$output" "main apply workflow should use the tracked manifest from repo root"
  assert_contains "mise exec -- npx skills" "$output" "main apply workflow should invoke the skills CLI through mise"
  pass "main make workflow includes agent skills installation"
}

test_install_fails_when_any_skill_install_fails() {
  local repo_copy test_home output status
  repo_copy="$(setup_repo_copy)"
  test_home="$repo_copy/test-home"

  cat > "$repo_copy/.skill-lock.json" <<'JSON'
{
  "version": 3,
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
  output="$(cd "$repo_copy" && HOME="$test_home" make agents-skills-install SKILLS="$repo_copy/test-skills.sh" SKILLS_NPX=true 2>&1)"
  status=$?
  set -e

  [ "$status" -ne 0 ] || fail "agents-skills-install should fail when any skill install fails"
  assert_contains "Installing docmost from dapi/docmost-cli" "$output" "install target should attempt the failing skill"
  pass "agents-skills-install propagates install failures"
}

test_add_merges_only_requested_skill() {
  local repo_copy test_home output resulting_skills
  repo_copy="$(setup_repo_copy)"
  test_home="$repo_copy/test-home"

  cat > "$repo_copy/.skill-lock.json" <<'JSON'
{
  "version": 3,
  "skills": {
    "docmost": {
      "source": "dapi/docmost-cli",
      "sourceType": "github",
      "sourceUrl": "https://github.com/dapi/docmost-cli.git",
      "skillPath": "SKILL.md",
      "skillFolderHash": "docmost"
    }
  },
  "lastSelectedAgents": [
    "codex",
    "claude-code"
  ]
}
JSON

  mkdir -p "$test_home/.agents"
  cat > "$test_home/.agents/.skill-lock.json" <<'JSON'
{
  "version": 3,
  "skills": {
    "docmost": {
      "source": "dapi/docmost-cli",
      "sourceType": "github",
      "sourceUrl": "https://github.com/dapi/docmost-cli.git",
      "skillPath": "SKILL.md",
      "skillFolderHash": "docmost"
    },
    "playwright-cli": {
      "source": "microsoft/playwright-cli",
      "sourceType": "github",
      "sourceUrl": "https://github.com/microsoft/playwright-cli.git",
      "skillPath": "skills/playwright-cli/SKILL.md",
      "skillFolderHash": "playwright"
    },
    "local-only": {
      "source": "example/private-skill",
      "sourceType": "github",
      "sourceUrl": "https://github.com/example/private-skill.git",
      "skillPath": "SKILL.md",
      "skillFolderHash": "private"
    }
  }
}
JSON

  output="$(cd "$repo_copy" && HOME="$test_home" make agents-skills-add SOURCE=microsoft/playwright-cli SKILL=playwright-cli SKILLS=true SKILLS_NPX=true)"
  resulting_skills="$(jq -r '.skills | keys[]' "$repo_copy/.skill-lock.json")"

  assert_contains "Updated tracked .skill-lock.json for playwright-cli" "$output" "agents-skills-add should report the curated merge"
  assert_contains "docmost" "$resulting_skills" "existing curated skills should remain in the tracked manifest"
  assert_contains "playwright-cli" "$resulting_skills" "requested skill should be merged into the tracked manifest"
  assert_not_contains "local-only" "$resulting_skills" "local-only global skills should not be copied into the tracked manifest"
  pass "agents-skills-add merges only the requested skill"
}

test_root_target_installs_into_runtime_directory
test_apply_includes_agents_install
test_install_fails_when_any_skill_install_fails
test_add_merges_only_requested_skill
