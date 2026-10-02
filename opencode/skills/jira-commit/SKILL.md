---
name: jira-commit
description: >
  Create git commits with a single-line summary prefixed by the Jira ticket id, e.g.
  "[NASTC-3965] Return info that app is not registered". Ticket id is taken from the current
  branch name (or asked from the user). Summary is generated from the diff against `develop`
  (or a baseline the user names explicitly). No commit body. Use when the user says "commit",
  "create a commit", "commit my changes", "jira commit", or invokes /jira-commit.
  Takes precedence over caveman-commit / Conventional Commits for commit creation.
---

Create a commit whose message is ONE line: `[<TICKET>] <Summary>`. No body, no trailers,
no Conventional Commits type, no AI attribution.

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

## Step 2 - Resolve the baseline

- Default baseline: `develop`.
- Use a different baseline ONLY if the user explicitly names one (e.g. "compare with main",
  "baseline release/1.4"). Never infer it from upstream tracking, PR target, or repo default.
- If `develop` does not exist locally, try `origin/develop`. If neither exists, ask the user
  which baseline to use.

## Step 3 - Gather the diff

Run in parallel:

```bash
git status --short
git diff --cached --stat
git diff --cached <BASELINE>           # baseline vs index: branch commits + staged changes
git diff --cached                      # only what this commit will contain
git log --oneline <BASELINE>..HEAD     # earlier commits on the branch
```

- If nothing is staged: show `git status --short` and ask whether to stage all changes
  (`git add -A`) or specific files. Do not stage silently.
- Never stage obvious secrets (`.env`, credentials, keys). Warn the user if they are staged.

Write the summary from the branch diff against the baseline, but make sure it describes
what THIS commit (staged changes) actually does. If the branch already has commits, avoid
repeating their summaries - focus on what is new.

## Step 4 - Write the summary

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

## Step 5 - Commit

```bash
git commit -m "[<TICKET>] <Summary>"
```

- Use exactly one `-m`. Never `--amend`, `--no-verify`, or `-i` unless the user explicitly asks.
- If a hook fails: fix the issue and create a new commit; do not amend.
- After committing, run `git log -1 --oneline` and show the result to the user.

## Quick checklist

- [ ] Ticket from branch, or asked from user (prefix dropped only on explicit request)
- [ ] Baseline is `develop` unless user explicitly named another
- [ ] Imperative, capitalized, no period, <= 72 chars total
- [ ] Single line, no body
