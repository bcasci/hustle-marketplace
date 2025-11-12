# Command Design Best Practices

## Core Principles

**Commands are executable prompts, not documentation.**

Good command:

- Clear scope and completion criteria
- Concise, imperative language
- Specifies output structure
- Prevents bloat through constraints

Bad command:

- Essay or tutorial style
- Vague success criteria
- Unbounded generation
- Meta-discussion mixed with directives

## Design Patterns

### 1. Action-Oriented Language

Use imperative verbs, not passive descriptions.

❌ Passive: "This command helps you understand..."
✅ Imperative: "Analyze codebase. Report: layout, key files, tech stack."

### 2. Executable Steps

Tell Claude what to DO, not describe process.

❌ Description: "First, the system will check prerequisites..."
✅ Directive: "CHECK: Verify Node version → ready_state"

### 3. Constrain Scope

Set boundaries explicitly.

❌ Unbounded: "Analyze this code and tell me about it."
✅ Constrained: "Analyze code. Report: purpose (1 sentence), dependencies (list), bugs (max 3)."

### 4. Specify Output Structure

Template-based formatting prevents verbosity.

❌ No structure: "Document this API endpoint."
✅ Structured: "## [METHOD] /path\nPurpose: {1 sentence}\nParams: {table}"

## When to Use Execution Flow Control

Multi-step workflows (3+ sequential steps) need flow control to prevent premature stopping.

### Complete Pattern Template

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

### For Skill Invocation Steps

Add sub-steps to ensure skill executes (not just narrates):

```markdown
2. OPTIMIZE: Execute {skill-name} skill completely:
   a. Run {skill-name} with {input}
   b. Execute skill's Process steps → outputs
   c. Extract needed sections → result
   d. DO NOT stop, DO NOT narrate - continue immediately to Step 3
```

### Critical Components

1. **Opening mandate**: "Execute this N-step workflow completely"
2. **Data flow notation**: "→" showing output passing between steps
3. **Explicit continuation**: "→ DO NOT STOP - continue immediately to Step X"
4. **Action-oriented labels**: CAPTURE, OPTIMIZE, PRESENT, ASK, EXECUTE
5. **EXECUTION RULES section**: Defines terminal states and completion criteria

### When It's Required

- ✅ 3+ sequential steps
- ✅ Steps consume previous output
- ✅ Skill/agent invocations (natural stop points)
- ✅ User approval gates (AskUserQuestion)
- ✅ Has a "PRESENT results" step (feels like natural completion)

### What Happens Without It

Commands stop at natural completion points:

- Step 3 "Present results" feels complete → stops, never reaches Steps 4-5
- Skill invocation returns result → feels like deliverable, stops instead of continuing
- Numbered steps imply sequence but don't mandate execution

## Argument Design

### Decision Tree

```
Variable input needed?
├─ NO → No arguments
└─ YES → Single value?
    ├─ YES → Use $ARGUMENTS
    └─ NO → Multiple distinct params?
        └─ YES → Use $1, $2, $3
```

### $ARGUMENTS vs Positional

**$ARGUMENTS**: Single/freeform (commit messages, search terms)
**$1, $2**: Multiple distinct, need defaults, structured

### Hints

Make descriptive and match usage.

❌ Vague: `argument-hint: [arg1] [arg2]`
✅ Clear: `argument-hint: [pr-number] [assignee]`

## Tool Permissions

### Least Privilege

Grant only tools actually needed.

**Bash patterns**:

- `Bash(git commit:*)` - specific command + any flags
- `Bash(git *:*)` - command family
- Avoid `Bash(*)` - too broad

**File tools**:

- Read-only: `Read, Grep, Glob`
- Write: `Read, Write`
- Edit: `Read, Edit`

**Integration**:

- Skills: `Skill(skill-name)`
- Agents: `Task`
- Questions: `AskUserQuestion`

## Commands vs Skills

### Use Command When

- Reusable prompt template
- Single file < 500 words
- No scripts/assets needed
- Quick workflows < 5 minutes

### Use Skill When

- Need references/ for docs
- Need scripts/ for automation
- Complex multi-mode operations
- Would exceed 500 words

## Location Strategy

### Project-Level (`./.claude/commands/`)

Team-shared, project-specific, collaboration

Examples: `/deploy-staging`, `/run-integration-tests`

### User-Level (`~/.claude/commands/`)

Personal productivity, cross-project, individual workflows

Examples: `/optimize-prompt`, `/create-commit`

### Decision

```
Specific to one project/team?
├─ YES → Project-level
└─ NO → User-level
```

## Anti-Patterns

### 1. Essay Style

❌ "This command helps you create docs. Docs are important..."
✅ "Create API docs: [Template] DO NOT include theory."

### 2. Vague Criteria

❌ "Help me understand this code."
✅ "Analyze: purpose (1 line), functions (list), dependencies (list), issues (max 3)."

### 3. Missing Flow Control

❌ "Step 1: Read\nStep 2: Optimize\nStep 3: Save"
✅ "Execute 3 steps: READ → content, OPTIMIZE → optimized, SAVE → done. Complete all."

### 4. Over-Permissive

❌ `allowed-tools: Bash(*)`
✅ `allowed-tools: Bash(git commit:*)`

### 5. Unclear Naming

❌ `helper.md`, `util.md`
✅ `create-commit.md`, `review-pr.md`

## Optimization

Always optimize command content via prompt-architecting before saving:

1. Draft initial content
2. Run prompt-architecting skill
3. Scaffold optimized content with front matter
4. Save complete file

Don't skip optimization - creates concise, bloat-free commands.

## Quality Checklist

Before saving:

- [ ] Descriptive kebab-case name
- [ ] Clear description (action + outcome)
- [ ] Arguments only if needed
- [ ] argument-hint if arguments used
- [ ] Specific allowed-tools
- [ ] Content optimized
- [ ] Flow control for 3+ steps
- [ ] Output structure specified
- [ ] Correct location
- [ ] Tested

## Complexity Guidelines

**Simple (50-150w)**: Single tool, template-based, no workflow
**Medium (150-300w)**: 2-4 tools, 2-3 steps, some structure
**Complex (300-500w)**: Multiple tools, 3+ steps, needs flow control
**Too complex (>500w)**: Consider making skill instead
