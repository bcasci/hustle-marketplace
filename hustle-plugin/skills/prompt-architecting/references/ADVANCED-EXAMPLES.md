# Advanced Optimization Examples: Workflows & Agents

Advanced case studies showing prompt-architecting for multi-step workflows and agent prompts.

## Example 5: Multi-Step Workflow Command

### Original Request

```
User: "Create a command that optimizes prompt files by using the prompt-architecting skill, checks for front matter dependencies, and writes the optimized version back"
```

### Without Optimization

Claude generates:

```
You are optimizing a Claude Code prompt file. Follow this workflow exactly:

## Step 1: Read File
Read the file at the path provided by the user.

## Step 2: Parse Structure
Detect YAML front matter and separate from content body.

## Step 3: Optimize Content
Use the prompt-architecting skill with the content.
Wait for skill to return optimized prompt.

## Step 4: Analyze Dependencies
Check if description has dependencies.

## Step 5: Present Results
Show optimization results and ask for approval.

## Step 6: Replace File
Write optimized content back to file.
```

**Result**: LLM stops after Step 3 (skill returns result), treating skill output as deliverable. Never proceeds to dependency analysis, approval, or file writing. User receives optimization output but file is never modified.

### With prompt-architecting

**Subagent analysis:**

- Task: Multi-step workflow command (6 sequential steps)
- Complexity: High (skill invocation, dependency checking, user approval, file I/O)
- Risk: Premature stopping after Step 3 (async skill call), skipped steps, no execution guarantee
- Bloat risks: Verbose step descriptions, missing flow control
- Optimal strategies: **Execution Flow Control** (critical), Decomposition, Directive Hierarchy, Constraint-Based

**Optimized prompt:**

```
Execute this 6-step workflow completely. Each step produces input for the next:

WORKFLOW:
1. READ: Use Read tool on $1 → content
2. PARSE: Extract front matter + body from content → {front_matter, body}
3. OPTIMIZE: Run your prompt-architecting skill to optimize body → optimized_body
4. ANALYZE: Use Grep to check dependencies in front_matter → risk_level
5. PRESENT: Show optimized_body + risk_level → STOP, WAIT for user approval
6. WRITE: If approved, use Write tool to save optimized_body + front_matter to $1 → done

EXECUTION RULES:
- Complete steps 1-5 without stopping
- STOP only at step 5 (user approval required)
- Proceed to step 6 only if user approves (yes/1/2)
- Task incomplete until step 6 completes or user cancels

Each step's output feeds the next. Do not stop early.
```

**Result**: Clear execution mandate, explicit data flow between steps, guaranteed completion through step 5, proper stop at approval gate, file gets written after approval.

**Why Execution Flow Control was critical:**

1. **Prevents premature stopping**: Mandate ensures execution continues after Step 3 skill invocation
2. **Explicit dependencies**: "Step X → output Y" shows each step consumes previous output
3. **Clear terminal states**: "STOP only at step 5" prevents arbitrary stopping
4. **Completion guarantee**: "Task incomplete until..." creates obligation to finish

**Lessons from this example:**

- Numbered steps alone don't guarantee sequential execution
- Skill invocations are natural stopping points - must mandate continuation
- Multi-step workflows need opening mandate + terminal state specification
- Data flow notation (→) makes dependencies explicit and prevents skipping

---

## Example 6: Agent Prompt with Multiple Modes

### Original Request

```
User: "Optimize this analyst agent prompt that has ~1,450 words with sections for new features, bug fixes, and gem verification"
```

### Without Agent/Workflow Guidelines

Claude generates:

- 1,450w → 560w (61% reduction - too aggressive)
- Removes procedural detail to hit 60% target
- Creates vague instructions: "Read relevant CLAUDE.md files" (which ones?)
- Pattern-finding detail only in "New Features", removed from "Bug Fixes"
- Agent doesn't know if bug fixes need same rigor as features
- Lost specificity: "ALL files (root + subdirectories)", "# AI: comments"

**Result**: Concise but vague. Agent has unclear guidance for bug fix mode.

### With Agent/Workflow Guidelines

**Subagent analysis:**

- Task: Optimize agent prompt with multiple modes
- Complexity: High (1,450 words, 3 modes: new features, bug fixes, gems)
- Risk: Over-optimization removes necessary procedural detail
- Bloat risks: Verbose YAML examples (90+ lines), Rails conventions, repetitive pattern-finding
- Optimal strategies: **Agent/Workflow Guidelines** (preserve procedural detail), DRY refactoring, Progressive Disclosure, Constraint-Based

**Optimized prompt:**

```
You are a requirements and architecture analyst. Tools: Read, Grep, Glob (read-only).

Follow output structure from @.claude/protocols/agent-output-protocol.md

## Core Philosophy

ULTRATHINK: Prioritize correctness over speed. AI implements fast regardless of approach. Strategic decisions matter most.

## Research Checklist

For ALL modes, check:
- ALL CLAUDE.md files (root + subdirectories)
- Similar implementations in codebase
- # AI: comments in existing code
- Test structure
- **For gem-backed features**: Gem capabilities before custom code

## Process

### For New Features

1. Read scratchpad if prompted: "Read scratchpad for context: [path]"
2. Understand requirement (ULTRATHINK): Core request, acceptance criteria, constraints
3. Find patterns (see Research Checklist above)
4. Determine approach:
   - Existing pattern → point to specific files
   - New pattern → recommend architecture fitting codebase style
5. Synthesize: Which files, patterns to follow, architecture rationale

### For Bug Fixes (from issue-diagnosis)

ULTRATHINK MODE: Think comprehensively about best solution.

1. Read scratchpad if prompted
2. Analyze bug nature: Where manifests? User impact? Larger architectural issue?
3. Research context (see Research Checklist above)
4. Evaluate ALL test levels (ULTRATHINK):
   - System: UI/JavaScript/user-visible bugs
   - Integration: Request/response/multi-component
   - Unit: Business logic/model behavior
   - Don't settle for "good enough" - recommend all appropriate tests
...

[Verbose YAML examples moved to references/analyst-examples.md]
```

**Result**: 1,450w → 650w (55% reduction - appropriate for agents). Preserved procedural detail while eliminating repetition via DRY refactoring.

**Why Agent/Workflow Guidelines were critical:**

1. **Recognized agent context**: Applied 40-50% target instead of 60%+
2. **DRY refactoring over deletion**: Extracted "Research Checklist" - eliminated repetition without losing specificity
3. **Preserved procedural detail**: "ALL CLAUDE.md files (root + subdirectories)" not "relevant files"
4. **All modes get rigor**: Bug fixes reference same Research Checklist as new features
5. **Aggressive optimization where appropriate**: 90-line YAML examples → references/

**Lessons from this example:**

- Agent prompts need execution detail - different standard than docs
- DRY refactoring beats deletion - extract shared sections instead of removing
- Target 40-50% for agents (not 60%+) - they need procedural clarity
- Preserve specificity: "ALL", "MANDATORY", "root + subdirectories"
- Recognize when detail is necessary vs when it's bloat
