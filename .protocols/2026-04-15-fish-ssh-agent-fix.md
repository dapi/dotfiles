# Fish SSH Agent Fix

Date: 2026-04-15

## Symptoms

- `fish` printed startup errors from `~/.config/fish/conf.d/20-keychain-gpg.fish`.
- Errors were caused by unmatched wildcard expansion for `/tmp/ssh-*/agent.*`.
- A new `ssh-agent` was being started on nearly every new `fish` session.
- `~/.ssh/agent.sock` briefly ended up pointing to itself instead of to a real socket.
- Many stale `ssh-agent` processes and stale socket files accumulated.

## Root Causes

- `fish` does not tolerate empty globs the same way `bash`/`zsh` do; unmatched globs are errors.
- The config searched mainly under `/tmp/ssh-*/agent.*`, but newly started agents were using sockets under `~/.ssh/agent/`.
- Because the existing agent was not found reliably, the config kept falling back to `eval (ssh-agent -c)`.
- The symlink update logic could preserve or recreate an invalid `~/.ssh/agent.sock` state.

## Changes Made

- Replaced fragile glob-based socket discovery with explicit reusable-agent lookup logic.
- Added `__ssh_agent_is_live` to validate candidate sockets through `ssh-add -l`.
- Added macOS-specific reusable socket discovery:
  - current `SSH_AUTH_SOCK`
  - stable symlink `~/.ssh/agent.sock`
  - newest valid sockets under `~/.ssh/agent/` and `/tmp/ssh-*`
- Added Linux-specific reusable socket discovery:
  - current `SSH_AUTH_SOCK`
  - systemd-managed `/run/user/<uid>/openssh_agent`
- Kept macOS-only behavior in the Darwin branch:
  - BSD `stat -f`
  - `ssh-add --apple-load-keychain`
- Left Linux in a separate branch so BSD/macOS-specific commands are not used there.
- Fixed `~/.ssh/agent.sock` to point to the actual live socket.
- Removed stale `ssh-agent` processes and stale socket files, keeping only the live agent.

## Why This Was Done

- Stop `fish` from throwing startup errors.
- Reuse one valid `ssh-agent` across terminal sessions instead of spawning a new one each time.
- Make the config explicit and maintainable across macOS and Linux.
- Prevent stale agents and stale sockets from accumulating.
- Preserve tmux/zellij-friendly agent reuse via a stable symlink.

## Result

- `fish` starts without wildcard errors.
- Repeated `fish` launches reuse the same `SSH_AUTH_SOCK`.
- Only one `ssh-agent` remains active after cleanup.
- `~/.ssh/agent.sock` points to a real live socket again.
