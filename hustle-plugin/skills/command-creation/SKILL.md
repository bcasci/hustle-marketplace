---
name: command-creation
description: Creates Claude Code slash commands with optimized content and proper front matter following official best practices. Use when user says 'create a command' or 'make a slash command'.
allowed-tools: Read, Write, AskUserQuestion, Skill(prompt-architecting), Bash(ls:*)
---

# Command Creation

## Purpose

Automate Claude Code slash command creation with proper front matter and optimized content.

**Mode**: ULTRATHINK - This skill has an important job. Take time to analyze requirements, design proper arguments, validate front matter, and ensure quality.

## Steps

### Step 1: Gather Requirements

Ask: "What should this command do?"

Extract: purpose, workflow, variable inputs. Infer kebab-case name (action-verb pattern).

### Step 2: Analyze Needs (ULTRATHINK)

Determine and explicitly STATE:

- **Arguments**: Variable input needed? → `$ARGUMENTS` (single) or `$1, $2` (multiple)
- **Tools**: Infer from workflow (git → Bash, files → Read/Write, search → Grep)
- **Workflow complexity** (CRITICAL - explicitly state this):
  - Count sequential steps needed for workflow
  - Check if workflow will run skills/subagents
  - Check if workflow needs user approval gates
  - **State explicitly**: "This command needs [X] sequential steps. Execution Flow Control: [REQUIRED/NOT REQUIRED]"
  - Rule: 3+ steps OR skill invocations OR approval gates → REQUIRED

Example output: "This command needs 5 sequential steps (read, parse, optimize, present, write). Has skill invocation. Execution Flow Control: REQUIRED"

See {baseDir}/references/BEST-PRACTICES.md for Execution Flow Control guidance.

### Step 3: Clarify Ambiguities

Use AskUserQuestion for: unclear arguments, ambiguous tools, location (project/user), multiple approaches.

Max 3 questions, 2-4 options each.

### Step 4: Build Front Matter (Interface First)

Define the command interface before implementation.

Valid fields (see {baseDir}/references/FRONT-MATTER-SPEC.md):

- `description` (always): Action + when to use (1 sentence)
- `argument-hint` (if args): `[param1] [param2]`
- `allowed-tools` (if needed): Explicit (e.g., `Bash(git commit:*)`)
- `model`, `disable-model-invocation` (rare)

**Why front matter first**: Description forces clarity, argument-hint determines content structure ($ARGUMENTS vs $1/$2), allowed-tools constrains implementation.

### Step 5: Validate Front Matter (ULTRATHINK)

Before drafting content, verify interface is correct:

- Valid YAML syntax
- Only valid fields (description, argument-hint, allowed-tools, model, disable-model-invocation)
- No fabricated fields (`references:`, `tags:`, etc.)
- Required: `description`

If invalid: fix and re-validate. Do not proceed to content drafting with invalid front matter.

### Step 6: Draft Content

Based on requirements, workflow pattern, and **front matter interface**.

Use front matter to guide content:

- If `argument-hint: [pr-number]` → use `$ARGUMENTS` in content
- If `argument-hint: [env] [branch]` → use `$1` and `$2` in content
- If `allowed-tools: Bash(git *)` → reference git commands

**Check Step 2's workflow complexity statement:**

Look at Step 2's explicit statement: "This command needs [X] sequential steps. Execution Flow Control: [REQUIRED/NOT REQUIRED]"

**IF Step 2 stated "Execution Flow Control: REQUIRED":**

You MUST draft using complete Execution Flow Control pattern (use Step 2's step count for N):

```markdown
Execute this N-step workflow completely. Each step produces input for the next:

**WORKFLOW:**

1. LABEL: Action description → output_name

2. LABEL: Action using output_name → next_output
   → DO NOT STOP - continue immediately to Step 3

3. PRESENT: Show results to user
   → DO NOT STOP - continue immediately to Step 4

4. ASK: Use AskUserQuestion tool → user_choice
   → Continue to Step 5 with user_choice

5. EXECUTE: Conditional action based on user_choice
   - If approved: Execute completely
   - If declined: Stop workflow

**EXECUTION RULES:**

- Complete steps 1-4 without stopping
- STOP only at step 4 for user approval
- Proceed to step 5 only if user approves
- Task incomplete until step 5 completes or user cancels
- Each step's output feeds the next - do not stop early
```

**For skill invocation steps specifically**, add sub-steps:

```markdown
2. OPTIMIZE: Execute {skill-name} skill completely:
   a. Run {skill-name} with {input}
   b. Execute skill's Process steps → outputs
   c. Extract needed sections → result
   d. DO NOT stop, DO NOT narrate - continue immediately to Step 3
```

**Why this pattern is critical:**

- Opening mandate establishes execution obligation
- Data flow notation (→) makes dependencies explicit
- Explicit continuation prevents stopping at "natural completion points"
- Action-oriented labels keep flow incomplete until final step
- EXECUTION RULES define terminal states and completion criteria

Without this, commands stop at Step 3 (PRESENT) which feels like natural completion.

Reference {baseDir}/references/COMMAND-EXAMPLES.md for patterns and {baseDir}/references/BEST-PRACTICES.md for more details.

### Step 7: Optimize Content

Execute optimization workflow:

1. Take Step 6 draft → draft_content
2. Run prompt-architecting skill → skill_output
   - Task: "Optimize this command prompt"
   - Content: draft_content
   - Output type: command
   - Complexity: By word count (low <300w, medium 300-600w, high >600w)
3. Extract "Optimized Prompt" section from skill_output → optimized_content

Complete all 3 sub-steps. Skill invocation in step 2 is NOT the final deliverable. Proceed immediately to Step 8 with optimized_content.

### Step 8: Save

Use `ls` to verify directory exists.

Write to `./.claude/commands/{name}.md` (project) or `~/.claude/commands/{name}.md` (user).

Format:

```markdown
---
{ validated front matter from Step 4/5 }
---

{optimized content from Step 7}
```

### Step 9: Deliver

Show: location, invocation (`/{name}` or `/{name} [args]`), usage example.

## Errors

**"Directory doesn't exist"**: `mkdir -p ./.claude/commands/` or `mkdir -p ~/.claude/commands/`
**"prompt-architecting not found"**: Verify at `~/.claude/skills/prompt-architecting/`
**"Invalid front matter"**: Check YAML syntax and valid fields only
