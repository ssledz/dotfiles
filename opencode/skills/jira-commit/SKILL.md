---
name: jira-commit
description: >
  Create git commits with a single-line summary prefixed by the Jira ticket id, e.g.
  "[NASTC-3965] Return info that app is not registered". Ticket id is taken from the current
  branch name (or asked from the user). Summary is generated from the changes in the current
  worktree (staged, unstaged, untracked). Stages and commits automatically without asking.
  Can also only generate the message without committing. No commit body. Use when the user
  says "commit", "create a commit", "commit my changes", "jira commit", "commit message",
  "generate commit message", or invokes /jira-commit.
  Takes precedence over caveman-commit / Conventional Commits for commit creation.
---

Create a commit whose message is ONE line: `[<TICKET>] <Summary>`. No body, no trailers,
no Conventional Commits type, no AI attribution.

## Step 0 - Pick the mode

- **Commit mode (default)**: stage and commit automatically. Do not ask for confirmation.
- **Message-only mode**: ONLY when the user explicitly asks just for the message, e.g.
  "only generate commit message", "just the message", "don't commit", "dry run",
  "suggest a commit message", `/jira-commit message`. Generate the message and print it;
  do not touch git state.

## Step 1 - Resolve the Jira ticket id

1. Get the branch: `git rev-parse --abbrev-ref HEAD`.
2. Extract the ticket with regex `[A-Za-z][A-Za-z0-9]+-[0-9]+` (first match), then uppercase it.
   - `feature/NASTC-3965-token-exchange` -> `NASTC-3965`
   - `nastc-3859_github-authie` -> `NASTC-3859`
3. If the result is `HEAD` (detached), there is no branch, or no ticket matches:
   **ask the user for the ticket id**. Do not invent or guess one.
4. Commit WITHOUT the `[TICKET]` prefix ONLY if the user explicitly asks for it in this
   request (e.g. "commit without ticket", "no jira prefix"). Never drop it on your own,
   including when the ticket is missing - ask instead.

## Step 2 - Detect worktree changes

Run in parallel:

```bash
git status --short --untracked-files=all   # every changed, staged, and untracked file
git diff --cached                          # staged changes
git diff                                   # unstaged changes to tracked files
```

For each untracked file listed in `git status` (`??`), read its content so new files are
part of the summary. Skip generated/binary files (build output, lockfiles, images) beyond
noting that they exist.

Decide what goes into the commit automatically - do NOT ask the user for confirmation:
- **No changes at all**: tell the user there is nothing to commit and stop.
- **Default**: include ALL worktree changes (staged, unstaged, untracked). In commit mode run
  `git add -A`; in message-only mode do not stage, just treat everything as included.
- **Narrower scope only on explicit request** in this message (e.g. "commit only staged",
  "commit only src/foo.scala"): include exactly that and leave the rest untouched.
- **Secrets**: never include obvious secrets (`.env`, credentials, private keys, tokens).
  Leave them unstaged (`git restore --staged <file>` if already staged), continue with the
  rest, and warn the user in the final output.

Write the summary from exactly the included changes. In commit mode, after staging run
`git diff --cached --stat` and base the summary on the final staged diff.

## Step 3 - Write the summary

Format: `[<TICKET>] <Summary>`

Rules (adapted from git/GitHub best practices):
- **Length**: whole line ideally <= 50 characters of summary text; hard cap 72 characters
  for the entire line including the `[TICKET] ` prefix. GitHub truncates subjects longer
  than 72 chars with an ellipsis in the UI. If you exceed 72, rewrite - do not truncate words.
- **Imperative mood**: "Add", "Fix", "Return", "Remove" - not "Added", "Adds", "Adding".
  Test: "If applied, this commit will <Summary>".
- Capitalize the first word after the prefix.
- No trailing period.
- One space between `]` and the summary.
- Describe intent/outcome, not file names or mechanics ("Return info that app is not
  registered", not "Change AppService.kt and AppController.kt").
- Plain ASCII, no emoji, no quotes or backticks around words unless essential.
- Single line only. Never add a body, blank line, `Co-authored-by`, or `Generated with ...`.

Examples:
- `[NASTC-3965] Fixes after code review`
- `[NASTC-3965] Return info that app is not registered`
- `[NASTC-3859] Add option to do token exchange between github and Authie`
- Without prefix (only when explicitly requested): `Bump Gradle wrapper to 8.10`

Bad:
- `[NASTC-3965] added new endpoint.` (past tense, lowercase, period)
- `NASTC-3965: Add endpoint` (wrong prefix format)
- `[NASTC-3965] feat(api): add endpoint` (no Conventional Commits types)
- Anything over 72 characters or with a body.

## Step 4 - Commit (or print the message)

**Message-only mode**: print the message in a code block and stop. Do not stage, commit, or
change the index or worktree in any way.

**Commit mode** (default): commit right away without asking for confirmation:

```bash
git commit -m "[<TICKET>] <Summary>"
```

- Use exactly one `-m`. Never `--amend`, `--no-verify`, or `-i` unless the user explicitly asks.
- If a hook fails: fix the issue and create a new commit; do not amend.
- After committing, run `git log -1 --oneline` and show the result to the user.

## Quick checklist

- [ ] Mode chosen: commit (default) or message-only (explicit request)
- [ ] Ticket from branch, or asked from user (prefix dropped only on explicit request)
- [ ] All worktree changes included automatically (minus secrets), unless user narrowed scope
- [ ] Summary describes exactly the included changes
- [ ] Imperative, capitalized, no period, <= 72 chars total
- [ ] Single line, no body
