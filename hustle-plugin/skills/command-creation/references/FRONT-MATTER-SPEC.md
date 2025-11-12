# Front Matter Specification

Official Claude Code command front matter fields.

## Available Fields

### description
**Type**: String
**Required**: No (defaults to first line)
**Purpose**: Brief explanation of what command does and when to use it

**Format**: Action verb + what + when to use (1 sentence)

Examples:
```yaml
description: Creates git commit with conventional format and attribution
description: Optimizes prompt files while preserving front matter
description: Reviews pull request and provides code quality feedback
```

### argument-hint
**Type**: String
**Required**: Only if command accepts arguments
**Purpose**: Shows expected parameters in autocomplete

**Syntax**:
- Single: `[message]`
- Multiple: `[pr-number] [assignee]`
- Alternatives: `add [tagId] | remove [tagId] | list`

Examples:
```yaml
argument-hint: [issue-number]
argument-hint: [environment] [branch]
argument-hint: [file-path]
```

### allowed-tools
**Type**: List of tool permission strings
**Required**: Only if specific tools needed
**Purpose**: Defines which tools command can use

**Patterns**:
```yaml
# Specific bash command
allowed-tools: Bash(git commit:*)

# Command family
allowed-tools: Bash(git *:*)

# Multiple tools
allowed-tools: Read, Write, Bash(npm test:*)

# Skill invocation
allowed-tools: Skill(prompt-architecting), Read, Write
```

### model
**Type**: String (model identifier)
**Required**: No (inherits from conversation)
**Purpose**: Specify which Claude model to use

**Values**:
- `claude-sonnet-4-5-20250929` (default)
- `claude-3-5-haiku-20241022` (faster/cheaper)
- `claude-opus-4-20250514` (most powerful)

Use only when specific model capabilities needed.

### disable-model-invocation
**Type**: Boolean
**Required**: No (default: false)
**Purpose**: Prevent SlashCommand tool from auto-invoking this command

Use for sensitive/destructive operations only.

## Decision Tree

```
START → Always include description

Need arguments? → YES → Add argument-hint
              → NO → Continue

Need specific tools? → YES → Add allowed-tools
                    → NO → Continue

Need specific model? → YES → Add model
                     → NO → Continue

Sensitive operation? → YES → Add disable-model-invocation: true
                     → NO → DONE
```

## Complete Example

```markdown
---
description: Deploys application to staging with verification
argument-hint: [branch]
allowed-tools: Bash(git *:*), Bash(npm *:*), Read
---

Deploy to staging from branch $1:

1. VERIFY: Check branch exists
2. BUILD: Run npm build
3. DEPLOY: Push to staging
4. SMOKE: Run health checks

Complete all steps.
```
