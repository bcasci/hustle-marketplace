---
name: skill-generator
description: Generate new Claude Code skills following official best practices. Use when user requests "create a skill" or "make a skill" for automating workflows or tasks.
allowed-tools: "Read, Write, Bash"
---

# Skill Generator

## Purpose

Generate minimal, workflow-focused Claude skills following official best practices.

**Core principle**: "Skills prepare Claude to solve a problem, rather than solving it directly." - Skills are workflows, not tutorials.

## Critical First Step

**STOP and ASK** if user hasn't specified:

- **Level**: User-level (`~/.claude/skills/`) or project-level (`.claude/skills/`)
- **What problem**: What specific task should this skill automate?

## Workflow

### Step 1: Classify Before Writing

Determine:
1. **Workflow**: What specific task to automate
2. **Knowledge**: Does Claude know this? (✅ Standard tools/patterns, ❌ Company-specific)
3. **Complexity**: Simple (30-80 lines, single workflow), Complex (80-200 lines, dependencies), Knowledge-heavy (50-100 lines + references, domain knowledge)
4. **Structure**: SKILL.md (workflow), references/ (domain knowledge only), scripts/ (deterministic operations)

### Step 2: Write Frontmatter

```yaml
---
name: workflow-name # lowercase, hyphens only, max 64 chars
description: What it does + when to use it. Include trigger words. Max 1024 chars.
allowed-tools: "Minimal, Set" # Only tools actually used (optional)
---
```

Description must be specific with trigger words:

- ❌ "Helps with documents"
- ✅ "Run pre-commit quality checks. Use when ready to commit code changes."

### Step 3: Write Workflow

Choose template based on Step 1 classification:

**Simple** (30-80 lines): Purpose → Steps → Output → Errors
**Complex** (80-200 lines): Purpose → Prerequisites → Steps → Output → Errors → Examples (optional)
**Knowledge-heavy** (50-100 lines + references): SKILL.md is minimal router, domain knowledge in references/

**For skills/commands that run other skills**, use Execution Flow Control pattern (see {baseDir}/references/OPTIMIZATION-GUIDE.md lines 90-119 for complete pattern and examples).

Template: {baseDir}/references/SKILL_TEMPLATE.md (placeholders for structure)
Examples: {baseDir}/references/examples/ (working implementations)

### Step 4: Decide on References

**Create reference ONLY IF**:

- Company-specific API schemas
- Custom business rules/regulations
- Proprietary data formats

**Test**: Can you answer "Why doesn't Claude know this?" in one sentence?

- Valid: "Company's proprietary API format"
- Invalid: "How to use git" (Claude knows git)

### Step 5: Create Files

```bash
# Simple workflow
mkdir -p {baseDir}
# Write SKILL.md only

# Knowledge-heavy
mkdir -p {baseDir}/references
# Write SKILL.md + reference files
```

Use forward slashes, {baseDir} for paths, never absolute paths.

### Step 6: Self-Critique

Before delivering, verify:

1. ✅ Description specific with trigger words?
2. ✅ SKILL.md is workflow (80%+ commands vs explanations)?
3. ✅ Under 5,000 words?
4. ✅ References justified (domain knowledge only)?
5. ✅ Tool permissions minimal?
6. ✅ Uses {baseDir}, forward slashes?

If any fail: revise.

### Step 7: Optimize Generated Skill

Execute optimization workflow:

1. Read {baseDir}/SKILL.md → current_content
2. run your prompt-architecting skill → skill_output
   - Task: Optimize generated skill with architecture compliance
   - Content: current_content
   - Output type: skill
   - Complexity: {from Step 1 - Simple/Complex/Knowledge-heavy}
   - Architecture reference: {baseDir}/references/SKILL-ARCHITECTURE.md
   - Mode: optimize
   - Constraints: Target 40-50% reduction of explanatory content while preserving required sections and patterns per architecture. Word count MAX (Simple 400w, Complex 800w, Knowledge-heavy 500w).
3. Extract "Optimized Prompt" section from skill_output → optimized_version
4. Use Write tool to replace {baseDir}/SKILL.md with optimized_version

Complete all 4 sub-steps without stopping. Running the skill in step 2 is NOT the final deliverable.

## Tool Permissions

Specify minimal tool set. Scope conservatively: ✅ `Bash(git:*)` ❌ `Bash(*)`

## Output Format

```text
Created {skill-name}
Location: {path}
Type: Simple/Complex/Knowledge-heavy
Files: SKILL.md {+ references if applicable}
```

## Errors

**"Missing input"**: User didn't specify level (user/project) or problem to solve. Ask: "Which level? What specific task should this skill automate?"

**"Invalid {baseDir} path"**: Directory path doesn't exist or isn't accessible. Verify path and try again.

**"Optimization failed"**: prompt-architecting skill returned error. Review generated skill manually, ensure it has required sections (Purpose, Workflow, Output).

**"Self-critique failed"**: Generated skill doesn't meet one or more criteria. Review checklist (Step 6), revise skill, retry optimization.

## Resources

- Skill architecture: {baseDir}/references/SKILL-ARCHITECTURE.md
- Optimization guide: {baseDir}/references/OPTIMIZATION-GUIDE.md
- Skill template: {baseDir}/references/SKILL_TEMPLATE.md
- Skill examples: {baseDir}/references/examples/
