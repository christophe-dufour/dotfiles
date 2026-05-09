# My Global Development Standards

## Git Workflow

- **Always create new branches from main branch after a fresh pull**
  - Never create branches from feature branches
  - Always run `git checkout main && git pull` before creating a new branch
  - Then create branch: `git checkout -b <branch-name>`

## Commit Standards

- Write clear, descriptive commit messages
- Keep commits focused and atomic

## Issue Workflow

  - Ask for review after completing the plan and wait for approval before proceeding
  - Once we agree on the plan, proceed with implementation
  - Ask for review before commit/push
  - Always commit and push at the same time (never commit without pushing) and open PR.
  - Use github template for PR description. Keep it concise.

## General Preferences

- Follow convention/documentions over existing code style
- Prefer clarity over cleverness
- Write DRY coode
- Write comments when they are valuable
- Tests should be derivated from specs, not from code

@RTK.md
