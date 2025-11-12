# Skill Optimization Guide

**WHAT**: Guidelines for optimizing Claude Code skills while preserving required architecture (what to preserve, what to optimize, target reductions, refactoring procedures).

**WHEN**: Read this when optimizing skills (prompt-architecting reads during Step 1 if architecture_reference provided).

**HOW**: Use preservation rules and refactoring procedures:
1. PRESERVE: Required sections, error patterns, output formats, asset references
2. OPTIMIZE: Verbose explanations, redundant examples (40-50% reduction target)
3. REFACTOR: Add missing required sections using procedures below
4. APPLY: Execution Flow Control pattern for multi-step workflows (3+ sequential steps)

**For**: prompt-architecting skill (automatic during optimization), developers (manual refinement)

**Related**: SKILL-ARCHITECTURE.md (WHAT structure required), examples/ (reference implementations)

## Preservation Rules

### MUST Preserve (never remove)

**Structural elements:**
- Required section headers (Purpose, Workflow/Steps, Output, Errors)
- Asset path patterns (`{baseDir}/...`)
- Error response patterns
- Insufficient input handling patterns
- Output format specifications

**Critical detail:**
- Specific error messages and solutions
- Numbered step sequences
- Format examples
- Prerequisites (if complex setup needed)

### CAN Optimize (reduce/relocate)

**Content within sections:**
- Verbose explanations
- Redundant examples (consolidate or move to references/)
- Defensive documentation ("Note that...", "Be aware...")
- Theoretical content ("This is important because...")
- Over-elaboration of obvious steps

**Relocation opportunities:**
- Edge cases → move to references/
- Library comparisons → move to references/
- Detailed examples → move to references/ (keep one in SKILL.md)
- Performance tuning → move to references/

## Target Reductions

| Skill Type      | Target Reduction | Rationale                              |
|-----------------|------------------|----------------------------------------|
| Simple          | 40-50%           | Needs workflow clarity                 |
| Complex         | 30-40%           | Needs procedural detail                |
| Knowledge-heavy | 40-50%           | Details moved to references/, not main |

**Do not exceed 50% reduction** - skills need execution detail.

## Refactoring Procedures

When skill is missing required sections, ADD them during optimization:

### Missing Purpose

```markdown
## Purpose

{Infer from frontmatter description and workflow - one sentence}
```

### Missing Output Format

```markdown
## Output

**Success**: {What the skill produces}
**Failure**: {How errors are communicated}
```

### Missing Error Handling

If workflow has failure modes:

```markdown
## Errors

**{Common error pattern}**: {Cause and solution}
```

## Content Patterns for Multi-Step Workflows

### Execution Flow Control Pattern

**When to use**: Skills containing 3+ sequential steps where:
- Steps consume output from previous steps
- Risk of premature stopping (especially after skill invocations)
- State transitions matter (approval gates, conditional branches)

**Pattern elements:**
1. Opening mandate: "Execute this N-step workflow completely"
2. Data flow notation: `Step X → output_name`
3. Explicit continuation: "→ DO NOT STOP - continue to Step X"
4. Action labels: CAPTURE, OPTIMIZE, PRESENT, EXECUTE, ASK
5. EXECUTION RULES section defining terminal states

**Example:**

```markdown
Execute this 4-step workflow completely:

1. READ: Use Read tool on $1 → content
2. PARSE: Extract sections from content → {sections}
3. VALIDATE: Check sections against requirements → validation_result
4. PRESENT: Show validation_result → done

EXECUTION RULES:
- Complete all steps without stopping
- Task incomplete until step 4 completes
```

**When NOT to use:**
- Simple linear workflows without dependencies
- Workflows where steps are independent
- Documentation/reference skills (not workflows)

### Language for Tool/Skill Usage

Use imperative verbs, not notation style:

✅ **Good (imperative):**
```markdown
3. OPTIMIZE: Run your prompt-architecting skill to optimize content → optimized
4. ANALYZE: Use Grep to search for patterns → matches
```

❌ **Bad (notation):**
```markdown
3. OPTIMIZE: Invoke prompt-architecting(content) → optimized
4. ANALYZE: Grep(pattern) → matches
```

Imperative creates clear directives; notation reads like documentation.

## Optimization Examples

### Example 1: Remove Verbose Explanation

**Before**: Theory + command (70w)
**After**: Command only (10w)
**Reduction**: 86% - removed formatter theory, kept executable instruction

### Example 2: Move Details to References

**Before**: Inline edge cases (encoding types, file sizes, BOM handling)
**After**: Reference pointer `{baseDir}/references/CSV-ENCODING.md`
**Reduction**: 60% in main file, details preserved

### Example 3: Consolidate Redundant Examples

**Before**: 3 separate file type examples
**After**: Single regex pattern covering all types
**Reduction**: 70% - consolidated into comprehensive example

## Common Over-Optimization Mistakes

### Mistake 1: Removing Required Sections

❌ **Wrong:**
```markdown
# Code Formatting

Format JavaScript with prettier, Python with black, then stage changes.
```

**Problem**: No Purpose, Workflow, Output, or Errors sections.

✅ **Correct:**
```markdown
# Code Formatting

## Purpose
Ensure consistent code formatting.

## Steps
{workflow}

## Output
{success/failure states}

## Errors
{common errors}
```

### Mistake 2: Making Instructions Vague or Generic

❌ **Wrong:**
```markdown
3. Check for patterns

## Errors
Handle any errors that occur during execution.
```

**Problems**:
- Vague workflow: What patterns? How to check?
- Generic errors: Not actionable

✅ **Correct:**
```markdown
3. Find patterns (MANDATORY):
   - Read ALL CLAUDE.md files (root + subdirectories)
   - Search similar implementations
   - Check # AI: comments

## Errors
**"prettier: command not found"**: Install: `npm install -D prettier`
**"black: command not found"**: Install: `pip install black`
```

## Optimization Checklist

Before finalizing optimization:

- [ ] All required sections present (Purpose, Workflow, Output, Errors)?
- [ ] Asset references use `{baseDir}` pattern?
- [ ] Error messages are specific and actionable?
- [ ] Insufficient input handling is clear?
- [ ] Execution Flow Control added (if 3+ sequential steps)?
- [ ] Target reduction achieved (30-50%)?
- [ ] No vague instructions ("check for patterns" → specific checklist)?
- [ ] Examples moved to references/ if verbose (keep one)?

## Summary

**Preserve structure, optimize content.** Skills need architectural consistency AND conciseness. Reduce bloat within sections, don't remove sections themselves.
