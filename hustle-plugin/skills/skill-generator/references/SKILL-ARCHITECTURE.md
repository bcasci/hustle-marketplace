# Skill Architecture Specification

**WHAT**: Defines required structure and patterns for Claude Code skill files (frontmatter, sections, patterns).

**WHEN**: Read this during skill creation or optimization to understand compliance requirements.

**HOW**: Use as checklist when creating/reviewing skills:

1. Verify required sections present (Purpose, Workflow, Output, Errors)
2. Check required patterns (asset references use `{baseDir}`, error format, output format)
3. During optimization: Pass this file path as `architecture_reference` to prompt-architecting skill (preserves structure while optimizing content)
4. For optimization details: See OPTIMIZATION-GUIDE.md (HOW to refine)
5. For template: See SKILL_TEMPLATE.md (placeholders)
6. For examples: See examples/ directory (working implementations)

**Scope**: Structure requirements (WHAT sections), not optimization procedures (HOW to optimize) or examples (demonstrating compliance).

## Frontmatter Requirements

All skills MUST have valid YAML frontmatter:

```yaml
---
name: skill-name                    # REQUIRED: lowercase, hyphens, max 64 chars
description: What + when to use     # REQUIRED: Specific with trigger words, max 1024 chars
allowed-tools: "Tool, Set"          # OPTIONAL: Minimal scoped set
---
```

**Description requirements:**

- Specific trigger words that match user intent
- When to use this skill (context)
- ❌ Bad: "Helps with documents"
- ✅ Good: "Format code before committing. Use when ready to commit or formatting code."

## Required Sections (all skills)

Skills MUST include these sections in SKILL.md body (in order):

### 1. Purpose

- One sentence or short paragraph
- What problem this solves
- Why this skill exists
- Example: "Generate minimal, workflow-focused Claude skills following official best practices."

### 2. Workflow / Steps / Process

- Sequential steps or clear workflow description
- Action-oriented headings: "Step 1: [Verb]", "Step 2: [Verb]"
- Executable instructions that can be performed
- For multi-step workflows (3+ steps), see content patterns in OPTIMIZATION-GUIDE.md

### 3. Output / Output Format

- What the skill produces
- Success/failure specifications
- Format examples if applicable
- Pattern:

  ```markdown
  ## Output

  **Success**: {specific description}
  **Failure**: {specific description with details}
  ```

### 4. Errors / Error Handling

- Common errors and solutions (if skill has failure modes)
- Pattern: `**"error message"**: Cause and solution`
- Insufficient input handling:

  ```markdown
  If {condition not met}:
  "Cannot proceed: {reason}. {Helpful guidance}"
  ```

## Optional Sections (complexity-dependent)

Add these sections when complexity demands:

- **Prerequisites**: Required tools/setup (complex workflows needing non-standard setup)
- **When to Use**: Additional clarification beyond frontmatter description (if description insufficient)
- **Tool Permissions**: Explanation of tool scoping (if needs documentation beyond frontmatter)
- **Examples**: Use cases showing application (complex workflows where usage not obvious)
- **Resources**: References to supporting files (when references/, scripts/, assets/ directories exist)

**Guideline**: Default to required sections only. Add optional sections when their absence would create confusion.

## Pattern Library

**Asset References**: Use `{baseDir}/references/FILE.md`, `{baseDir}/scripts/script.sh`, `{baseDir}/assets/template.json` (never absolute paths)

**Insufficient Input**: `If {condition}: "Cannot proceed: {reason}. {Guidance}"`

**Error Format**: `**"error message"**: Cause and solution`

**Output Format**: `**Success**: {state}` / `**Failure**: {state with details}` OR code block showing structure

## Architecture Compliance

Verify: ✅ Purpose, Workflow, Output, Errors (if applicable), `{baseDir}` references, frontmatter (name + description with trigger words). Flag missing elements for addition.

See skill-generator SKILL.md Step 1 for complexity classification guidance.

---

**Summary**: Skills follow Purpose → Workflow → Output → Errors structure. Optimize content within sections, preserve the sections themselves.
