#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

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

test_himalaya_uses_homebrew_on_macos() {
  local output
  output="$(cd "$repo_root" && make -n himalaya UNAME=Darwin)"

  assert_contains "brew install himalaya" "$output" "himalaya should install via Homebrew on macOS"
  assert_not_contains "install.sh" "$output" "macOS install should not use the upstream shell installer"
  pass "himalaya uses Homebrew on macOS"
}

test_himalaya_uses_upstream_installer_on_linux() {
  local output
  output="$(cd "$repo_root" && make -n himalaya UNAME=Linux)"

  assert_contains 'curl -sSL https://raw.githubusercontent.com/pimalaya/himalaya/master/install.sh | PREFIX="$HOME/.local" sh' "$output" "himalaya should install via the upstream installer on Linux"
  assert_not_contains "sudo apt-get install -y himalaya" "$output" "linux install should not assume an apt package exists"
  pass "himalaya uses the upstream installer on Linux"
}

test_other_packages_keep_default_package_managers() {
  local linux_output darwin_output
  linux_output="$(cd "$repo_root" && make -n ag UNAME=Linux)"
  darwin_output="$(cd "$repo_root" && make -n ag UNAME=Darwin)"

  assert_contains "sudo apt-get install -y silversearcher-ag" "$linux_output" "existing Linux packages should still use apt"
  assert_contains "brew install the_silver_searcher" "$darwin_output" "existing macOS packages should still use Homebrew"
  pass "default package manager flow still works for regular packages"
}

test_himalaya_uses_homebrew_on_macos
test_himalaya_uses_upstream_installer_on_linux
test_other_packages_keep_default_package_managers
