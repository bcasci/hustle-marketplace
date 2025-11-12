# Skill Template

Use this template to create new skills. Replace ALL placeholders in [brackets] with actual content.

---

```markdown
---
name: [skill-name-lowercase-hyphens]
description: [What it does + when to use it. Include trigger words like "use when", "before", "during". Max 1024 chars.]
allowed-tools: "[Tool, Set]"  # Optional: Only include tools actually used
---

# [Skill Name Title Case]

## Purpose

[One sentence or short paragraph explaining what problem this solves and why this skill exists.]

## Steps

### Step 1: [Action Verb - e.g., Detect, Run, Check]

[Clear instructions or commands for this step]

```bash
[command here if applicable]
```

[Any conditional logic: "If X, then Y"]

### Step 2: [Action Verb]

[Clear instructions for next step]

### Step 3: [Action Verb]

[Final step instructions]

## Output

**Success**: [Specific description of success state - e.g., "✓ All tests passed"]
**Failure**: [Specific description of failure state with details - e.g., "✗ Tests failed: {count} failures"]

## Errors

**"[specific error message text]"**: [Why this happens and how to fix it]
**"[another error message]"**: [Cause and solution]
**"[if no framework detected]"**: [Guidance for user]

## Optional Sections (add if needed)

### Prerequisites

[Only include if complex setup required - e.g., "Rails project with pending migrations"]

### Examples

[Only include for complex workflows where usage isn't obvious]

**Example 1: [Scenario]**
[Show how to use]

### Resources

[Only include if skill uses references/, scripts/, or assets/ directories]

- Reference docs: {baseDir}/references/[FILE].md
- Scripts: {baseDir}/scripts/[script].sh
- Assets: {baseDir}/assets/[template].json
```

---

## Usage

See {baseDir}/SKILL-ARCHITECTURE.md for architecture requirements and examples/ for working implementations.
