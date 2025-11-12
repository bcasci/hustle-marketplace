# Command Examples

Good vs bad command design patterns.

## Example 1: Git Commit

### ❌ Bloated
```markdown
---
description: Creates comprehensive git commits
argument-hint: [message]
allowed-tools: Bash(*)
---

You are creating a git commit. First check git status carefully.
Review all changes. Think about whether changes are related.
Then examine using git diff. Review each change carefully.
Stage files using git add. Make sure only staging related files.
Finally create commit with proper message...
```

**Problems**: Essay-like, over-permissive tools, no execution flow

### ✅ Optimized
```markdown
---
description: Creates git commit with conventional format
argument-hint: [message]
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*)
---

Execute commit workflow:

1. STATUS: Run git status → changed_files
2. DIFF: Run git diff → changes
3. ADD: Stage files with git add
4. COMMIT: Create commit:

$ARGUMENTS

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>

Complete all steps.
```

## Example 2: Multi-Step Workflow

### ❌ Without Execution Flow Control
```markdown
---
description: Reviews pull request
---

Step 1: Fetch PR details
Step 2: Read code changes
Step 3: Analyze for issues
Step 4: Provide feedback
```

**Problem**: May stop after any step, no data flow

### ✅ With Execution Flow Control
```markdown
---
description: Reviews PR with actionable feedback
argument-hint: [pr-number]
allowed-tools: Bash(gh pr view:*), Bash(gh pr diff:*)
---

Execute PR review:

1. FETCH: Use gh pr view $ARGUMENTS → pr_details
2. DIFF: Use gh pr diff $ARGUMENTS → code_changes
3. ANALYZE: Check bugs, security, performance → issues
4. REPORT: Format as [SEVERITY] Location: Fix

Complete steps 1-4. Do not stop early.
```

## Argument Patterns

### Pattern A: $ARGUMENTS (Single/Freeform)
```markdown
---
argument-hint: [search-term]
---

Search codebase for: $ARGUMENTS
```

Use when: Single variable, freeform text, no defaults needed

### Pattern B: $1, $2 (Positional)
```markdown
---
argument-hint: [environment] [branch]
---

Deploy to $1 from branch $2.

Environment: ${1:-staging}
Branch: ${2:-main}
```

Use when: Multiple distinct params, need defaults, structured input

## Tool Permissions

### ❌ Too Broad
```yaml
allowed-tools: Bash(*)
```

### ✅ Specific
```yaml
allowed-tools: Bash(git commit:*), Bash(git add:*)
```

### ✅ Command Family
```yaml
allowed-tools: Bash(git *:*)
```

## Naming

### ❌ Poor
- `helper.md`
- `do-stuff.md`
- `myCommand.md`

### ✅ Good
- `create-commit.md`
- `review-pr.md`
- `optimize-prompt.md`

Pattern: `{action}-{object}.md`
