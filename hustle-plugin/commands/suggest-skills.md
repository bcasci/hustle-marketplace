---
name: suggest-skills
description: Analyzes prompt files and recommends extracting reusable logic into skills
argument-hint: [file-path]
---

# PURPOSE

You are analyzing a prompt file to identify opportunities for skill extraction.

## Step 1: Read and Analyze Prompt

Read the file at path: `$1`

If no path provided (`$1` is empty), ask user for the file path.

Analyze the prompt content for extraction candidates:

**Identify if prompt contains:**

- Repeated multi-step workflows (3+ steps appearing 2+ times)
- Complex subprocess with clear input/output boundaries (>200 words, self-contained)
- Domain-specific logic that could apply to other prompts
- Tool-heavy sections that could be reused

**For each candidate, document:**

- Proposed skill name (action-oriented, gerund form: `processing-X`, `building-Y`)
- What it would handle (1 sentence)
- Lines/sections to extract from current prompt
- Justification (why worth extracting)

**Output MAX 3-5 skill candidates.** DO NOT suggest extraction for:

- Prompts <300 words total
- One-off logic with no reuse potential
- Simple template sections

## Step 2: Check for Duplicate Skills

Before presenting options to user, check if proposed skills already exist:

1. **Search user-level skills**:

   - Glob `~/.claude/skills/*/SKILL.md`
   - Read each SKILL.md to check name and description
   - Match by: similar name, overlapping functionality

2. **Check available skills**:

   - Review list of available skills from plugins/MCP
   - Current known skills: draft-github-issues, publish-github-issues, prompt-architecting, saas-pricing-strategy, skill-generator

3. **For each duplicate found**:
   - Note which existing skill covers this functionality
   - Remove from candidate list
   - Prepare recommendation to use existing skill instead

## Step 3: Present Options

Use AskUserQuestion tool to present candidates:

**If 0 candidates after deduplication:**

```text
No new skills recommended. Existing skills already cover identified patterns:
- {pattern description} → Use {existing-skill-name}
- {pattern description} → Use {existing-skill-name}

Suggestion: Use /optimize-prompt-file to reduce verbosity without extracting logic.
```

**If 1+ candidates remain:**

```text
Question: "Which skills should I extract from this prompt?"
multiSelect: true
Options:
  - label: "{skill-name-1}"
    description: "Handles {what it does}. Extracts {section description}."
  - label: "{skill-name-2}"
    description: "Handles {what it does}. Extracts {section description}."
  ...
  - label: "None - keep as-is"
    description: "Don't extract any skills"
```

**Also inform user about existing skills:**

```text
ℹ️  Existing skills that could be used:
- {existing-skill-name}: {what it does}
```

## Step 4: Execute User Choice

Based on user selection:

**If "None - keep as-is"**: Exit with no changes.

**If 1+ skills selected**:

For each selected skill:

1. **Run your skill-generator skill** with:

   - Skill name: {selected-name}
   - Purpose: {what it handles}
   - Context: Extracted from {original-file-path}
   - Content to extract: {specific sections/logic}
   - Location: Ask user (user-level `~/.claude/skills/` or project-level `.claude/skills/`)

2. Wait for skill-generator to complete

3. Verify skill was created successfully

## Step 5: Refactor Original Prompt

Once all skills created:

1. **Replace extracted logic** with skill invocations:

   - Find sections that were extracted
   - Replace with: "Run {skill-name} skill to handle {purpose}"
   - Update workflow steps to reference skill calls

2. **Preserve front matter** exactly (never modify)

3. **Show diff** to user:

   ```text
   Changes to {file-path}:

   - [Removed: Lines X-Y - extracted to {skill-name}]
   + [Added: Run {skill-name} skill]

   Before: {original-word-count} words
   After: {new-word-count} words ({reduction}% reduction)

   Proceed with refactoring? [yes/no]
   ```

4. **Apply changes** if user approves:
   - Write refactored content + original front matter back to file
   - Report success with summary

## Important Rules

- NEVER create skills manually - ALWAYS use skill-generator skill
- ALWAYS check for duplicate skills before presenting options
- ALWAYS preserve front matter exactly
- REQUIRE user approval before refactoring original prompt
- DO NOT suggest extraction for prompts <300 words
- DO NOT auto-extract without user selection via AskUserQuestion
- If extraction would leave original prompt <50 words, warn that it may be too aggressive

## Example Output

```text
Analyzing /Users/name/.claude/commands/complex-workflow.md...
Current: 650 words

Identified 3 extraction candidates:
1. validating-yaml-structure (lines 45-120): Validates YAML files against schemas
2. batch-file-processing (lines 200-280): Processes multiple files with progress tracking
3. generating-reports (lines 350-420): Creates markdown reports from structured data

Checking for duplicates...
✅ No existing skills match these patterns

Which skills should I extract from this prompt?
□ validating-yaml-structure - Handles YAML validation logic
□ batch-file-processing - Handles multi-file processing with progress
□ generating-reports - Handles report generation from data
☑ None - keep as-is
```
