# Advanced Anti-Patterns: Workflow & Agent Optimization

**CRITICAL**: For detailed stopping point analysis, see `/Users/brandoncasci/.claude/tmp/workflow-optimization-spec.md`

**CRITICAL**: For safety guidelines and dimensional analysis, see `OPTIMIZATION-SAFETY-GUIDE.md`

**KEY INSIGHT**: Most stopping risk patterns are caused by over-technical notation (Dimension 3). Simplifying notation while preserving appropriate structure solves the problem.

---

Advanced patterns for optimizing multi-step workflows and agent prompts.

## Pattern 6: Numbered Steps Without Execution Mandate

### ❌ Verbose

```
You are optimizing a Claude Code prompt file. Follow this workflow exactly:

## Step 1: Read File

Read the file at the path provided by the user. If no path provided, ask for it.

## Step 2: Parse Structure

- Detect YAML front matter (content between `---` markers at file start)
- If front matter exists, extract `name` field
- Separate front matter from content body

## Step 3: Optimize Content

Use the prompt-architecting skill with:
- Task description: "Optimize this prompt"
- Current content: {content body without front matter}

Wait for skill to return optimized prompt. DO NOT implement optimization yourself.

## Step 4: Analyze Dependencies

Check if description has dependencies by searching codebase.

## Step 5: Present Results

Show optimization results and ask for approval.

## Step 6: Replace File

Write optimized content back to file.
```

**Problem**: Numbered steps imply sequence but don't mandate complete execution. LLM may stop after Step 3 (skill returns result) treating it as a deliverable. No guarantee all steps execute sequentially or that Step N uses Step N-1 output.

### ✅ Optimized

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

**Strategies applied**: Execution Flow Control, Decomposition, Directive Hierarchy, Output Formatting

**Key improvements**:
- Opening mandate: "Execute this 6-step workflow completely"
- Explicit data flow: "Step X → output Y"
- Clear terminal states: "STOP only at step 5"
- Completion guarantee: "Task incomplete until step 6"
- Prevents premature stopping after async operations (skill invocations)

---

## Pattern 7: Removing Procedural Detail as "Bloat" (Agent/Workflow Prompts)

### ❌ Over-optimized

```
## Process

### For New Features

1. Read scratchpad if prompted
2. Understand requirement (ULTRATHINK): Core request, acceptance criteria, constraints
3. Find patterns (MANDATORY):
   - Read relevant CLAUDE.md files
   - Search similar implementations
   - Check test structure
   - For gem-backed features: Verify gem capabilities FIRST
4. Determine approach:
   - Existing pattern → point to specific files
   - New pattern → recommend architecture fitting codebase style
5. Synthesize: Which files, patterns to follow, architecture rationale

### For Bug Fixes

1. Read scratchpad if prompted
2. Analyze bug nature: Where manifests? User impact? Larger architectural issue?
3. Evaluate ALL test levels (ULTRATHINK):
   - System: UI/JavaScript/user-visible bugs
   - Integration: Request/response/multi-component
   - Unit: Business logic/model behavior
```

**Problem**:
- "Read relevant CLAUDE.md files" - vague (which ones? just root? subdirectories?)
- Pattern-finding detail only in "New Features" mode, removed from "Bug Fixes"
- Agent doesn't know if bug fix mode needs same rigor as new features
- Lost specificity: "ALL files (root + subdirectories)", "# AI: comments", specific checklist items
- Aggressive 60%+ reduction created ambiguity

### ✅ Properly optimized

```
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
```

**Strategies applied**: Execution Flow Control + DRY refactoring, Agent/Workflow Guidelines

**Key improvements**:
- Extracted shared "Research Checklist" - eliminates repetition without losing detail
- Preserved ALL specificity: "ALL CLAUDE.md files (root + subdirectories)", "# AI: comments"
- Applied to all modes - bug fixes get same rigor as new features
- DRY refactoring instead of deletion - saves ~40 words while maintaining clarity
- 40-50% reduction (appropriate for agents) vs 60%+ (too aggressive)

**When this pattern applies**:

- Optimizing agent prompts or workflow commands
- Multiple modes/sections with similar procedural steps
- Procedural detail appears repetitive but is actually necessary
- Target reduction is 60%+ (too aggressive for agents)

**How to avoid**:

- Extract shared checklists instead of deleting detail
- Preserve specific qualifiers: "ALL", "MANDATORY", "root + subdirectories"
- Target 40-50% reduction for agents (not 60%+)
- Ask: "Does removing this create vagueness?" If yes, refactor instead

---

## Pattern 8: Defensive Meta-Commentary and Stop-Awareness

### ❌ Creates stopping risk through negative priming

```markdown
**Step 3: OPTIMIZE** → optimized_body

- Use Skill tool: Skill(skill="prompt-architecting")
- WAIT for skill output (contains multiple sections)
- EXTRACT text under "## Optimized Prompt" heading → optimized_body
- → DO NOT STOP - this is NOT the end - continue to Step 6 after Step 4

**CRITICAL REMINDERS:**

- The Skill tool (Step 3) returns structured output with multiple sections
- You MUST extract the "## Optimized Prompt" section and store as optimized_body
- Receiving skill output is NOT a completion signal - it's just data for Step 6
- NEVER return control to caller after Step 3 - continue to Steps 4 and 6
- The ONLY valid stopping points are: Step 5 (waiting for user) or Step 6 (done writing)
- If you find yourself returning results without calling Write tool, you failed
```

**Problem**:

- Each "DO NOT STOP" warning creates decision point: "Should I stop here?"
- "This is NOT the end" reinforces that ending is a possibility
- CRITICAL REMINDERS section acknowledges failure mode, normalizing it
- "If you find yourself returning results... you failed" describes the exact unwanted behavior
- Defensive commentary creates stop-awareness, making premature stopping MORE likely

**Psychological mechanism** (Ironic Process Theory):

- Telling someone "don't think about X" makes them think about X
- Repeatedly saying "DO NOT STOP" primes stopping behavior
- Meta-commentary about failure normalizes and increases failure

### ✅ Trust structure, eliminate stop-awareness

```markdown
Your job is to update the file with optimized prompt from your skill.

Read the file, extract any front matter. Run the prompt-architecting skill on the content body. Check for dependencies if front matter exists. Ask user for approval if dependencies found. Write the optimized content back to the file.
```

**Or, if complexity requires structure:**

```markdown
Execute this workflow completely:

1. READ: Use Read(file_path) → content
2. OPTIMIZE: Run prompt-architecting skill on content → optimized_content
3. CHECK: If front matter exists, search for dependencies → risk_level
4. APPROVE: If risk_level high, ask user → approval
5. WRITE: Save optimized_content to file → done

Task completes at step 5.
```

**Strategies applied**: Natural Language Reframing (first example) or moderate EFC without defensive warnings (second example)

**Key improvements**:

- No "DO NOT STOP" warnings anywhere
- No CRITICAL REMINDERS section discussing failure modes
- No meta-commentary about what might go wrong
- Structure implies continuation naturally
- Task framing makes completion criteria obvious

**When this pattern applies**:

- Any workflow with skill/agent invocations
- Multi-step processes where premature stopping is a risk
- Prompts that have been "fixed" by adding more warnings

**How to avoid**:

- Frame positively: "Continue to X" instead of "DO NOT STOP"
- Remove all meta-commentary about failures
- If you need warnings, the structure is wrong - simplify instead
- Trust natural language and clear structure over defensive reminders
- Test: If prompt mentions stopping/failure, you're creating the problem
