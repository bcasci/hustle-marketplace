# Complex Skill Example: Creating Pull Request

**Architecture compliance**: ✅ Demonstrates required + optional sections for Complex skill type (80-200 lines)

---

````markdown
---
name: creating-pull-request
description: Create pull request with commits, issue linking, and reviewer assignment. Use when ready to create PR or submit code for review.
allowed-tools: "Bash(git:*), Bash(gh:*)"
---

# Creating Pull Request

## Purpose

Automate PR creation with proper commits, issue linking, description, and reviewer assignment.

## Prerequisites

- Git repository with remote
- GitHub CLI (`gh`) authenticated
- Changes committed to feature branch

## Steps

### Step 1: Verify Branch State

```bash
git status
git log main..HEAD --oneline
```
````

Ensure branch is ahead of main with commits.

### Step 2: Push Branch

```bash
git push -u origin $(git branch --show-current)
```

### Step 3: Extract Issue Number

```bash
BRANCH=$(git branch --show-current)
ISSUE=$(echo $BRANCH | grep -oP '(?<=issue-)\d+' || echo "")
```

If branch follows `feature/issue-123` pattern, extract issue number.

### Step 4: Generate PR Description

```bash
COMMITS=$(git log main..HEAD --pretty=format:"- %s")
```

List all commits since branching from main.

### Step 5: Create PR

```bash
if [ -n "$ISSUE" ]; then
  gh pr create --title "$(git log -1 --pretty=%s)" \
    --body "Closes #$ISSUE

## Changes
$COMMITS

## Test Plan
- [ ] Unit tests pass
- [ ] Manual testing completed" \
    --reviewer @team/reviewers
else
  gh pr create --fill --reviewer @team/reviewers
fi
```

### Step 6: Verify PR Created

```bash
gh pr view --web
```

Open PR in browser for review.

## Output

**Success**:

```
✓ Branch pushed: feature/issue-123
✓ PR created: #456
✓ Reviewers assigned: @team/reviewers
✓ Linked to issue: #123
```

**Failure**:

```
✗ PR creation failed: {error}
Troubleshooting: {specific guidance}
```

## Errors

**"gh: command not found"**: GitHub CLI not installed. Install: `brew install gh` (Mac) or `sudo apt install gh` (Linux)

**"failed to push some refs"**: Branch exists remotely with different commits. Pull remote changes first: `git pull origin $(git branch --show-current)`

**"No commits between main and HEAD"**: No changes to create PR from. Ensure commits exist on feature branch before creating PR

**"authentication required"**: GitHub CLI not authenticated. Run `gh auth login` and follow prompts

## Examples

### Example 1: Feature Branch with Issue

```bash
# Current branch: feature/issue-123
# Commits: "Add user profile component", "Add tests"
```

Process: Extracts issue #123, creates PR titled "Add user profile component", links to issue, assigns reviewers.

### Example 2: Hotfix Branch

```bash
# Current branch: hotfix/fix-login-bug
# Commits: "Fix null pointer in login"
```

Process: No issue extracted, creates PR with commit message as title, assigns reviewers.

```

---

**Why this is well-architected:**
- ✅ Complete structure: Purpose → Prerequisites → Steps → Output → Errors → Examples
- ✅ Complex type (140 lines): Multi-stage with dependencies and conditional logic
- ✅ Real automation: PR creation with issue linking, reviewer assignment
- ✅ Specific errors: 4 errors using bold pattern (not h3 headings)
- ✅ Multiple scenarios: Feature branch vs hotfix examples
- ✅ No bloat: Direct instructions, no git theory
```
