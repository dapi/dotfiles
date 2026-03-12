#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
hook_source="$repo_root/.githooks/pre-commit"

HOOK_STATUS=0
HOOK_OUTPUT=""
FAKE_GITLEAKS_LOG=""
SETUP_REPO_RESULT=""
SETUP_TOOL_DIR=""
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

setup_repo() {
  local repo
  repo="$(mktemp -d "${TMPDIR:-/tmp}/dotfiles-pre-commit-test.XXXXXX")"
  TEST_REPOS+=("$repo")

  git -C "$repo" init -q
  git -C "$repo" config user.name "Dotfiles Test"
  git -C "$repo" config user.email "dotfiles@example.com"
  mkdir -p "$repo/.githooks"
  cp "$hook_source" "$repo/.githooks/pre-commit"
  chmod +x "$repo/.githooks/pre-commit"

  printf 'seed\n' > "$repo/.gitignore"
  git -C "$repo" add .gitignore
  git -C "$repo" commit -q -m "init"
  SETUP_REPO_RESULT="$repo"
}

setup_fake_mise_toolchain() {
  local repo="$1"
  local exit_code="$2"
  local stderr_message="$3"
  local tool_dir

  tool_dir="$repo/test-bin"
  mkdir -p "$tool_dir"
  FAKE_GITLEAKS_LOG="$repo/fake-gitleaks.log"

  cat > "$tool_dir/mise" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

if [ "${1:-}" = "which" ] && [ "${2:-}" = "gitleaks" ]; then
  printf '%s\n' "${FAKE_GITLEAKS_PATH:?}"
  exit 0
fi

exit 1
EOF

  cat > "$tool_dir/fake-gitleaks" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

printf '%s\n' "$*" > "${FAKE_GITLEAKS_LOG:?}"
if [ -n "${FAKE_GITLEAKS_STDERR:-}" ]; then
  printf '%s\n' "$FAKE_GITLEAKS_STDERR" >&2
fi

exit "${FAKE_GITLEAKS_EXIT_CODE:-0}"
EOF

  chmod +x "$tool_dir/mise" "$tool_dir/fake-gitleaks"

  export FAKE_GITLEAKS_PATH="$tool_dir/fake-gitleaks"
  export FAKE_GITLEAKS_LOG
  export FAKE_GITLEAKS_EXIT_CODE="$exit_code"
  export FAKE_GITLEAKS_STDERR="$stderr_message"
  SETUP_TOOL_DIR="$tool_dir"
}

run_hook() {
  local repo="$1"
  local path_prefix="$2"
  local stdout_file stderr_file

  stdout_file="$repo/hook.stdout"
  stderr_file="$repo/hook.stderr"

  if (cd "$repo" && PATH="$path_prefix:/usr/bin:/bin" .githooks/pre-commit >"$stdout_file" 2>"$stderr_file"); then
    HOOK_STATUS=0
  else
    HOOK_STATUS=$?
  fi

  HOOK_OUTPUT="$(cat "$stdout_file" "$stderr_file")"
}

test_allows_safe_change_and_invokes_gitleaks() {
  local repo tool_dir log_output
  setup_repo
  repo="$SETUP_REPO_RESULT"
  setup_fake_mise_toolchain "$repo" 0 ""
  tool_dir="$SETUP_TOOL_DIR"

  printf 'hello\n' > "$repo/notes.txt"
  git -C "$repo" add notes.txt

  run_hook "$repo" "$tool_dir"

  [ "$HOOK_STATUS" -eq 0 ] || fail "safe staged change should pass"
  log_output="$(cat "$FAKE_GITLEAKS_LOG")"
  assert_contains "git --staged --no-banner --redact --log-level warn" "$log_output" "hook should invoke gitleaks on staged changes"
  pass "safe staged change passes gitleaks scan"
}

test_blocks_forbidden_gnupg_files_before_scanner() {
  local repo tool_dir
  setup_repo
  repo="$SETUP_REPO_RESULT"
  setup_fake_mise_toolchain "$repo" 0 ""
  tool_dir="$SETUP_TOOL_DIR"

  mkdir -p "$repo/.gnupg/private-keys-v1.d"
  printf 'secret\n' > "$repo/.gnupg/private-keys-v1.d/key"
  git -C "$repo" add .gnupg/private-keys-v1.d/key

  run_hook "$repo" "$tool_dir"

  [ "$HOOK_STATUS" -ne 0 ] || fail "forbidden .gnupg path should fail"
  assert_contains "refusing to commit sensitive .gnupg files" "$HOOK_OUTPUT" "hook should explain .gnupg rejection"
  if [ -e "$FAKE_GITLEAKS_LOG" ]; then
    fail "gitleaks should not run when .gnupg whitelist check fails"
  fi
  pass "forbidden .gnupg path is blocked before scanning"
}

test_propagates_gitleaks_failure() {
  local repo tool_dir
  setup_repo
  repo="$SETUP_REPO_RESULT"
  setup_fake_mise_toolchain "$repo" 1 "mock gitleaks detected a secret"
  tool_dir="$SETUP_TOOL_DIR"

  printf 'leaky\n' > "$repo/app.env"
  git -C "$repo" add app.env

  run_hook "$repo" "$tool_dir"

  [ "$HOOK_STATUS" -ne 0 ] || fail "gitleaks failure should fail the hook"
  assert_contains "mock gitleaks detected a secret" "$HOOK_OUTPUT" "hook should surface gitleaks output"
  pass "gitleaks failure blocks commit"
}

test_requires_gitleaks_when_not_available() {
  local repo
  setup_repo
  repo="$SETUP_REPO_RESULT"

  printf 'hello\n' > "$repo/plain.txt"
  git -C "$repo" add plain.txt

  run_hook "$repo" ""

  [ "$HOOK_STATUS" -ne 0 ] || fail "missing gitleaks should fail the hook"
  assert_contains "gitleaks is required for pre-commit secret scanning" "$HOOK_OUTPUT" "hook should explain missing gitleaks"
  pass "missing gitleaks is reported clearly"
}

test_allows_safe_change_and_invokes_gitleaks
test_blocks_forbidden_gnupg_files_before_scanner
test_propagates_gitleaks_failure
test_requires_gitleaks_when_not_available
