---
name: start-work-on
description: >
  Start work on a Jira ticket or an existing branch by creating a new git worktree.
  Input is either a Jira ticket id (e.g. NASTC-4392) or a branch name
  (e.g. feature/NASTC-4392-enable-obtaining-a-user-access-token-for-a-custom-audience).
  For a ticket id: fetches the ticket summary via jira-mcp, builds branch
  `feature/<TICKET>-<slugified-summary>` (max 77 chars), creates it from `develop`
  (unless another base is given) and adds a worktree whose path equals the branch name.
  For a branch name: creates the worktree directly from that branch (no Jira needed).
  Use when the user says "start work on", "start working on NASTC-1234", "create worktree for",
  or invokes /start-work-on.
---

Create a git worktree for a Jira ticket or an existing branch. The worktree directory
ALWAYS equals the branch name (slashes included), relative to the repo container root.

## Step 0 - Classify the input

- Matches `^[A-Za-z][A-Za-z0-9]+-[0-9]+$` (e.g. `NASTC-4392`, `nastc-4392`) -> **ticket mode**.
  Uppercase it.
- Contains `/` or otherwise looks like a branch name (e.g. `feature/NASTC-4392-foo`,
  `bugfix/x`) -> **branch mode**. Skip Jira entirely (Steps 2-3 and Step 6).
- Ambiguous / missing -> ask the user.

Optional: user may name a base branch ("from main", "based on release/1.2"). Default base: `origin/develop` (always the remote ref, never local `develop`).

## Step 1 - Locate the repo container root

Repos use a bare layout: `<root>/.bare` + worktrees as subdirectories of `<root>`.

```bash
git worktree list
```

- The `(bare)` entry's parent directory is `<root>` (e.g. `/Users/.../git/authie/.bare` -> `/Users/.../git/authie`).
- If no bare entry, use the parent directory of the main worktree (`git rev-parse --path-format=absolute --git-common-dir` -> dirname of repo top-level).

Worktree path = `<root>/<branch-name>`.

## Step 2 - Ensure jira-mcp is available (ticket mode only)

1. Check whether `jira-mcp_*` tools (e.g. `jira-mcp_jira_get_issue`) are callable.
2. If yes -> remember `JIRA_WAS_ENABLED=true`, continue.
3. If not -> remember `JIRA_WAS_ENABLED=false`, then in `~/.config/opencode/opencode.json`
   set `mcp.jira-mcp.enabled` to `true` (edit only that field). MCP servers load at startup,
   so tell the user: "jira-mcp enabled — restart opencode and rerun `/start-work-on <TICKET>`."
   and STOP. (Alternatively, if the user provides the summary text themselves, skip Jira and continue.)

## Step 3 - Fetch the summary (ticket mode only)

Call `jira-mcp_jira_get_issue` with `issue_key=<TICKET>`, `fields="summary"`.
If not found -> report and stop.

## Step 4 - Build the branch name (ticket mode only)

1. Slugify summary: lowercase, replace any run of non `[a-z0-9]` chars with `-`, trim leading/trailing `-`.
2. Branch = `feature/<TICKET>-<slug>` (ticket keeps uppercase).
3. **Max length 77 chars** (= length of
   `feature/NASTC-4392-enable-obtaining-a-user-access-token-for-a-custom-audience`).
   If longer, write a SHORTER meaningful summary yourself (drop filler words, abbreviate,
   keep key nouns/verbs) - do not just truncate mid-word. Re-check length; never exceed 77.
4. Example: `NASTC-4392` "Enable obtaining a user access token for a custom audience"
   -> `feature/NASTC-4392-enable-obtaining-a-user-access-token-for-a-custom-audience`.

## Step 5 - Create the worktree

ALWAYS fetch first, before any branch/worktree creation, so the new worktree is up to date:
`git fetch origin --prune`. If fetch fails, report and stop (do not create from stale refs).

Existence checks:
- Worktree path already exists -> report it, stop.
- `git worktree list` shows branch already checked out elsewhere -> report path, stop.

**Ticket mode** (new branch):
- If branch already exists locally (`git show-ref --verify refs/heads/<branch>`) or on
  remote (`refs/remotes/origin/<branch>`) -> treat as branch mode.
- Else:
  ```bash
  git worktree add -b "<branch>" "<root>/<branch>" "origin/<base>"
  git -C "<root>/<branch>" branch --unset-upstream 2>/dev/null || true
  ```
  Base is ALWAYS a remote ref: default `origin/develop`; a user-given base `X` becomes
  `origin/X`. Never branch from a local branch. If `origin/<base>` does not exist after fetch,
  report and stop. Unset upstream so the new branch does not track develop.

**Branch mode** (existing branch):
- Local branch exists -> `git worktree add "<root>/<branch>" "<branch>"`
- Only remote exists -> `git worktree add --track -b "<branch>" "<root>/<branch>" "origin/<branch>"`
- Neither exists -> ask whether to create it from `origin/develop` (or `origin/<given base>`); if yes use the
  ticket-mode command.

## Step 6 - Restore jira-mcp state (ticket mode only)

If `JIRA_WAS_ENABLED=false` (we enabled it in an earlier run for this skill) and Jira is not
needed further, set `mcp.jira-mcp.enabled` back to `false` in `~/.config/opencode/opencode.json`.
If you cannot tell whether it was enabled only for this skill, ask the user before disabling.

## Step 7 - Report

Print: branch name, base, worktree path, and `cd "<root>/<branch>"`.

## Rules

- Never run destructive git commands (no `reset --hard`, `branch -D`, `worktree remove`, force).
- Do not commit or push.
- Do not touch other fields of `opencode.json`.
