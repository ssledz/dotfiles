---
name: conventional-commits
description: Enforces Conventional Commits specification for git commit messages. Use when preparing, creating, or validating commits, commit messages, or when the user mentions commit, git commit, or commit changes.
metadata:
  version: "1.0"
  author: ssledz
---

## Overview

This skill enforces the [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/) specification for all git commit messages. Conventional commits provide a structured format that enables automated changelog generation, semantic versioning, and better project history understanding.

## When to Use

- User asks to commit changes
- User asks to prepare a commit message
- User mentions "commit", "git commit", or "commit message"
- After completing implementation work
- Before running `git commit`

## Commit Message Format

A conventional commit message MUST follow this structure:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Required Elements

**Type (REQUIRED)**
Must be one of:
- `feat` - A new feature (correlates with MINOR in SemVer)
- `fix` - A bug fix (correlates with PATCH in SemVer)

**Other allowed types** (no SemVer impact):
- `docs` - Documentation changes only
- `style` - Code style changes (formatting, missing semicolons, etc.)
- `refactor` - Code refactoring (neither fixes bug nor adds feature)
- `perf` - Performance improvements
- `test` - Adding or updating tests
- `build` - Build system or dependency changes
- `ci` - CI configuration changes
- `chore` - Other changes that don't modify src or test files
- `revert` - Reverts a previous commit

**Description (REQUIRED)**
- Short summary of changes
- MUST be in lowercase (except proper nouns)
- MUST NOT end with period
- Use imperative mood ("add" not "added", "fix" not "fixed")

### Optional Elements

**Scope (OPTIONAL)**
- Provides additional contextual information
- Must be a noun describing a section of the codebase
- Surrounded by parentheses: `feat(api):`, `fix(auth):`
- Common scopes: component names, modules, packages

**Breaking Change (OPTIONAL but IMPORTANT)**
- Indicated by `!` after type/scope: `feat!:`, `fix(api)!:`
- OR as a footer: `BREAKING CHANGE: <description>`
- Correlates with MAJOR in SemVer

**Body (OPTIONAL)**
- Additional contextual information
- MUST begin one blank line after description
- May contain multiple paragraphs
- Explain WHAT and WHY, not HOW

**Footers (OPTIONAL)**
- One or more footers one blank line after body
- Format: `<token> <space>: <space><value>` or `<token> <space>#<space><value>`
- Common footers: `Refs:`, `Reviewed-by:`, `Closes:`
- BREAKING CHANGE footer is special: `BREAKING CHANGE: <description>`

## Examples

### Simple commit
```
feat: add user authentication
```

### Commit with scope
```
fix(api): handle null response from external service
```

### Commit with breaking change indicator
```
feat!: remove deprecated user endpoint

BREAKING CHANGE: The user endpoint has been removed. Use the new users endpoint instead.
```

### Commit with body
```
fix: prevent racing of requests

Introduce a request id and a reference to latest request. Dismiss
incoming responses other than from latest request.

Remove timeouts which were used to mitigate the racing issue but are
obsolete now.
```

### Commit with body and footers
```
fix: prevent racing of requests

Introduce a request id and a reference to latest request.

Refs: #123
Reviewed-by: Z
```

### Documentation commit
```
docs: update installation instructions
```

### Refactoring commit
```
refactor(user): simplify authentication logic
```

### Revert commit
```
revert: let us never again speak of the noodle incident

Refs: 676104e, a215868
```

## Workflow

When preparing a commit:

1. **Check for changes**: Run `git status` to see what files have changed
2. **Review changes**: Run `git diff --staged` or `git diff` to understand what changed
3. **Stage files**: Run `git add <files>` if files are not staged
4. **Determine type**: Based on the nature of changes:
   - New feature → `feat`
   - Bug fix → `fix`
   - Documentation only → `docs`
   - Formatting/style → `style`
   - Refactoring → `refactor`
   - Performance → `perf`
   - Tests → `test`
   - Build/dependencies → `build`
   - CI changes → `ci`
   - Other → `chore`
   - Revert → `revert`
5. **Determine scope**: Which component/module/package is affected?
6. **Check for breaking changes**: Will this break existing API or behavior?
7. **Write description**: Short, imperative, lowercase summary
8. **Add body (if needed)**: Explain WHAT and WHY
9. **Add footers (if needed)**: References, reviews, etc.
10. **Validate message**: Use the validation checklist below

## Validation Checklist

Before committing, verify the message:

- [ ] Has type (feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert)
- [ ] Type is followed by colon and space
- [ ] Description is present and meaningful
- [ ] Description is in lowercase (except proper nouns)
- [ ] Description does NOT end with period
- [ ] Description uses imperative mood ("add" not "added")
- [ ] If scope is used, it's in parentheses after type
- [ ] If breaking change, includes `!` after type/scope OR `BREAKING CHANGE:` footer
- [ ] Body (if present) starts with blank line after description
- [ ] Footers (if present) follow format `<token>: <value>` or `<token> #<value>`
- [ ] Message is under 72 characters per line (subject line should be under 50)

## Common Mistakes to Avoid

### ❌ Wrong
```
Add new feature
```
Missing type.

### ❌ Wrong
```
feat: Add new feature
```
Description should be lowercase.

### ❌ Wrong
```
feat: add new feature.
```
Description should not end with period.

### ❌ Wrong
```
fix: fixed the bug
```
Should use imperative mood ("fix" not "fixed").

### ❌ Wrong
```
feat: add new feature for the authentication system
```
Should use scope: `feat(auth): add authentication`

### ❌ Wrong
```
Breaking change: remove old endpoint
```
Should be: `feat!: remove old endpoint` with footer

## Handling Multiple Changes

If a single commit includes multiple types of changes:
- Split into multiple commits if possible
- Use the dominant type for the commit
- Include details in body to describe other changes

## Tools and Integration

This skill integrates with:
- Automated changelog generators
- Semantic versioning tools
- Release automation
- CI/CD pipelines

## Notes

- Conventional commits are case-insensitive (except BREAKING CHANGE)
- Be consistent with scope naming across your project
- The `!` notation and `BREAKING CHANGE:` footer are equivalent
- Use `Refs:` or `Closes:` footers to link to issue/PR numbers
