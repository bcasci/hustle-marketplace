# Comprehensive Optimization Spec v2: The Complete Guide

## Executive Summary

**Core Insight**: Optimization is bidirectional, not just compression.

Based on empirical testing, we discovered:

1. **Over-optimization is real**: You can make prompts worse by over-optimizing
2. **Three dimensions exist**: Verbosity (bloat), Structure (complexity mismatch), Notation (technical ceremony)
3. **Bidirectional optimization**: Both "compress bloat" AND "simplify over-technical" are valid optimizations
4. **Cognitive load is the metric**: Does it make the prompt easier or harder to understand?
5. **LLMs prefer natural language**: Technical notation often creates more problems than it solves

This guide ensures the prompt-architecting skill is a **trustworthy asset** that makes prompts clearer, not just different.

---

## Part 1: The Optimization Philosophy

### What Is Optimization?

**Wrong definition**: Making prompts shorter, more structured, or more technical.

**Right definition**: **Reducing cognitive load while preserving intent.**

Optimization succeeds when:

- The prompt is **clearer** to understand
- The LLM can **execute more reliably**
- Intent and requirements are **fully preserved**
- Appropriate **complexity level** for the task

### The Bidirectional Model

Optimization operates on **three dimensions**:

#### Dimension 1: Verbosity

```
BLOATED ←→ CONCISE
"comprehensive guide covering all aspects..."  ←→  "MAX 300w: [Setup][Usage][Errors]"
```

#### Dimension 2: Structure

```
WRONG COMPLEXITY ←→ RIGHT COMPLEXITY
Simple task with formal workflow  ←→  Natural language
Complex task with vague prose     ←→  Appropriate structure
```

#### Dimension 3: Notation (NEW INSIGHT)

```
OVER-TECHNICAL ←→ ORGANIZED NATURAL
CAPS + → + variables + warnings  ←→  Clear conversational structure
```

### The Cognitive Load Test

**Central principle**: Does the optimization reduce or increase cognitive load?

**For each change, ask:**

1. Is it easier to understand?
2. Is it easier for LLM to execute?
3. Does it preserve all requirements?
4. Is the complexity match appropriate?

**If all YES → good optimization**
**If any NO → harmful optimization**

### Why LLMs Prefer Natural Language

LLMs are **language models**, not programming language parsers.

**They excel at:**

- Conversational instructions
- Natural connectors ("then", "if", "when", "while")
- Outcome-focused descriptions
- Organized prose

**They struggle with:**

- Heavy symbolic notation (CAPS, →, variables)
- Function call syntax when unnecessary
- Over-decomposition (sub-steps a/b/c)
- Defensive meta-instructions ("DO NOT STOP")

**Exception**: Technical notation helps when it reduces ambiguity MORE than natural language would. Examples: API specs, data schemas, mathematical notation.

**Default bias**: When cognitive load is equal, prefer natural language for LLM audiences.

---

## Part 2: When NOT to Optimize

### Recognition Criteria

**DO NOT optimize if ANY of these are true:**

#### 1. Already Optimal Patterns

**Indicators:**

- Deliverable-first framing present ("Your job:", "Goal:")
- Natural language flow with clear connectors
- Inline completion criteria
- Appropriate complexity match (simple task = simple language, complex task = structure)
- No bloat indicators
- Word count appropriate for complexity
- Notation level appropriate (natural unless precision required)

**Example:**

```markdown
Your job: Optimize the file at $1 and write it back.

Read the file, check for frontmatter. If frontmatter exists, search for dependencies and ask how to proceed. Optimize the content using provided guidance. Write the result back. The file edit is the deliverable.
```

**Why not optimize**: Already concise, clear, outcome-focused, appropriately structured, uses natural language. Optimization would likely make it worse.

#### 2. Natural Language at Right Complexity Level

**Indicators:**

- 1-2 step task in single sentence
- Sequence obvious and linear
- No approval gates, branching, or terminal states
- Enumeration would add no clarity
- Natural connectors work perfectly

**Example:**

```markdown
Read the configuration file, update the version number, and write it back.
```

**Why not optimize**: Adding numbered steps or formal structure would create unnecessary complexity.

#### 3. Callable Entity Descriptions

**Indicators:**

- Content is a `description` field for front matter
- Contains both contextual "when" AND trigger phrases
- Already follows additive format: "[What] when [context]. When user says '[triggers]'"
- Delegation signals present if needed (PROACTIVELY, MUST)

**Example:**

```markdown
description: Explores codebases when search spans multiple locations or naming is ambiguous. When user says "how does X work?", "find files matching", or when searches need 3+ rounds.
```

**Why not optimize**: Trigger phrases are functional pattern-matching signals. Over-optimization removes invocation clarity.

#### 4. Agent/Workflow Prompts at Appropriate Detail Level

**Indicators:**

- Procedural detail serves execution clarity
- Word count is 40-50% of original bloated version
- Specific qualifiers present ("ALL files", "root + subdirectories", "MANDATORY")
- No defensive meta-commentary
- Shared checklists extracted (DRY refactoring applied)

**Example:**

```markdown
## Research Checklist

For ALL modes:

- ALL CLAUDE.md files (root + subdirectories)
- Similar implementations in codebase
- # AI: comments in existing code
```

**Why not optimize**: Already at correct detail level for agent guidance. Further reduction creates vagueness.

#### 5. Technical Notation Serving Clear Purpose

**Indicators:**

- Notation is standard convention (API specs, data schemas, math)
- Precision prevents ambiguity that natural language couldn't
- Audience expects technical format
- Visual structure aids comprehension (tables, diagrams)
- No excessive ceremony (CAPS + → + variables + warnings)

**Example:**

```markdown
## [METHOD] /path

Purpose: {1 sentence}
Params: {table: name, type, required, description}
Response: {JSON schema only}
```

**Why not optimize**: Technical format is appropriate for API reference. Natural language would be less clear.

#### 6. User Explicitly Requests Preservation

**Indicators:**

- User says "keep the style", "don't change the tone", "just fix X"
- User provides context that current form is intentional
- Content is from production system with proven effectiveness

**Why not optimize**: User intent overrides optimization potential.

### Decision Tree: Should I Optimize?

```
START: Analyze content

Already optimal pattern?
├─ YES → NO OPTIMIZATION
└─ NO → Continue

Does it have bloat indicators?
(comprehensive, robust, adjective-heavy, >2x ideal length, unnecessary repetition)
├─ YES → Dimension 1 problem (verbosity) → Continue to complexity check
└─ NO → Check other dimensions

Structure mismatch?
(simple task + formal structure OR complex task + vague prose)
├─ YES → Dimension 2 problem (structure) → Continue
└─ NO → Check notation

Over-technical notation?
(CAPS + → + variables + warnings + function syntax + sub-step enumeration)
├─ YES → Dimension 3 problem (notation) → Continue to solution
└─ NO → Check if callable entity

Is it callable entity description?
├─ YES → Check trigger preservation
│   ├─ Has context + triggers? → MINOR optimization only
│   └─ Missing layer? → ADD missing layer
└─ NO → Determine which dimensions need optimization

FOR EACH DIMENSION NEEDING WORK:
1. Calculate complexity score
2. Select 1-3 complementary strategies
3. Apply transformations
4. Verify cognitive load reduced
```

---

## Part 3: Three Dimensions of Optimization

### Dimension 1: Verbosity (Bloat → Concise)

#### Detection Criteria

**Bloat indicators:**

- Adjective-heavy: "comprehensive", "robust", "enterprise-grade", "production-ready"
- Scope inflation: "all aspects", "everything", "fully cover"
- Vague quality statements: "best practices", "industry standards"
- Meta-discussion instead of instructions: "I think we should probably..."
- Defensive over-coverage: listing every possible edge case
- Embedded reasoning: explaining why instructions matter
- Conversational filler: "and stuff", "basically", "you know"
- Repetition: saying same thing multiple ways

**Example:**

```markdown
# BLOATED

I need you to create comprehensive documentation that covers all aspects of user authentication in our system. This should include detailed explanations of how the system works, what technologies we're using, best practices for implementation, common pitfalls to avoid, security considerations, edge cases, error handling strategies, and example code showing different use cases. Make sure it's thorough and covers everything a developer might need to know.
```

#### Transformation Strategies

1. **Remove adjectives and quality statements**

   - "comprehensive guide" → "guide"
   - "robust, production-ready" → (remove entirely)

2. **Set hard boundaries**

   - Add MAX word counts
   - Use template structure
   - Apply scope limits

3. **Exclude known bloat patterns**

   - "DO NOT: Include HTTP theory, framework comparisons"

4. **Define success concretely**
   - "Target: New dev can deploy in <10 min"

**Optimized:**

```markdown
Write auth docs. Structure: [Setup - 100w] [Usage - 150w] [Error handling - 100w] [One example - code only]. MAX 400 words total. Audience: Mid-level dev familiar with JWT. DO NOT: Include security theory, framework comparisons, or "best practices" sections.
```

**Strategies applied**: Constraint-Based, Output Formatting, Negative Prompting

**Reduction**: ~85% (200 words → 30 words)

### Dimension 2: Structure (Wrong Complexity → Right Complexity)

#### Detection Criteria

**Too much structure for simplicity:**

- 1-2 trivial steps with numbered workflow
- Formal EXECUTION RULES for obvious sequence
- CAPS labels for simple actions
- Multiple sections for straightforward task

**Too little structure for complexity:**

- 5+ sequential steps as prose paragraph
- Multiple approval gates without clear flow
- Terminal states not explicit
- Branching logic buried in narrative

**Complexity score formula:**

- 1-2 steps with obvious sequence? → **-1 point**
- 3-4 steps where sequence matters? → **+1 point**
- 5+ sequential steps? → **+2 points**
- User approval gates (WAIT, AskUserQuestion)? → **+3 points**
- 2+ terminal states (different end conditions)? → **+2 points**
- 3-way+ conditional branching? → **+2 points**
- Simple if/else conditionals only? → **+0 points**
- Skill invocation just for data? → **+0 points**
- Skill invocation affects control flow? → **+1 point**

**Score interpretation:**

- **≤ 0**: Natural language sufficient (over-structure would hurt)
- **1-2**: Light structure helpful (simple numbered steps or bullets)
- **3-4**: Moderate structure needed (organization without heavy formality)
- **≥ 5**: Full formal structure warranted (complex workflow management)

#### Transformation Strategies

**For over-structured (score ≤ 0, but has formal structure):**

```markdown
# TOO MUCH STRUCTURE

Execute this 3-step workflow completely:

1. READ: Load file → content
2. MODIFY: Update field → updated
3. WRITE: Save updated → done

EXECUTION RULES:

- Complete all steps sequentially
- Stop only at completion

# RIGHT AMOUNT (natural language)

Read the file, update the field, and write it back.
```

**Strategy**: Natural Language Reframing

**For under-structured (score ≥ 3, but vague prose):**

```markdown
# TOO LITTLE STRUCTURE

Read the file, check dependencies, ask the user, optimize based on choice, and write back, making sure to handle all the different cases appropriately.

# RIGHT AMOUNT (organized structure)

Goal: Optimize file while handling dependencies

Tools: prompt-architecting, AskUserQuestion, grep

Workflow:

1. Read file and parse structure
2. Check dependencies if frontmatter exists
3. Present options and gather user preference
4. Optimize content based on selection
5. Write result with appropriate handling

If user cancels at step 3, stop here. Otherwise complete all steps.
```

**Strategy**: Execution Flow Control (appropriate level for score)

### Dimension 3: Notation (Over-Technical → Organized Natural)

#### Detection Criteria

**Over-technical indicators:**

1. **CAPS labels as action markers**

   - `CHECK:`, `PARSE:`, `DETECT:`, `VALIDATE:`, `ANALYZE:`
   - Makes steps feel like function names
   - Creates discrete units that feel "complete" when done

2. **→ notation for data flow**

   - `Read file → content`, `Parse input → requirement_data`
   - Mimics programming assignment
   - Makes steps feel like functions with return values
   - Creates stopping points when "variables are populated"

3. **Variable naming conventions**

   - `work_file_status`, `requirement_data`, `pattern_found`, `analyst_output`
   - Treats prompt like code
   - LLM must mentally track variable state

4. **Function call syntax**

   - `skill({params})`, `Pass parameters: {intent: "detection"}`
   - Over-specifies how to invoke tools
   - LLM already knows tool invocation syntax

5. **Sub-step enumeration**

   - `a. Pass parameters b. Extract results c. DO NOT narrate`
   - Over-decomposition creates multiple boundaries
   - Prose would be clearer

6. **Defensive meta-instructions**
   - "DO NOT narrate", "continue immediately to Step 4"
   - Creates stop-awareness (Ironic Process Theory)
   - Signals that stopping is a possibility

**Count indicators**: If 3+ present → over-technical notation detected

**Cognitive load test**: Does the notation make it easier or harder to understand?

- Easier → Keep it (justified)
- Harder → Simplify it (organized natural language better)
- Same → Prefer natural (lower cognitive load)

#### When Technical Notation Helps vs. Hurts

**✅ Technical notation HELPS when:**

- **Precision prevents ambiguity**: API specs need exact format
- **Standard convention**: JSON schema, regex patterns, mathematical notation
- **Visual structure essential**: Tables, tree diagrams (not prose)
- **Audience expects technical**: Code generation, data transformation specs
- **Natural language would be vaguer**: Template structures, format requirements

**❌ Technical notation HURTS when:**

- **Creates execution risk**: CAPS + → + variables = stopping points
- **Adds cognitive load**: Must "parse" syntax instead of reading
- **Over-specifies obvious things**: "Pass parameters" when that's how tools work
- **Mimics programming unnecessarily**: Variable names for implicit data flow
- **Audience is LLM**: Language models understand conversation better than symbols
- **Defensive warnings needed**: If notation requires warnings, it's wrong

#### Transformation Strategy

**Pattern**: Keep appropriate structure, remove ceremonial notation

**Example transformation (complex workflow):**

**BEFORE (over-technical, high stopping risk):**

```markdown
Execute this 8-step workflow completely. Each step produces input for the next:

1. CHECK: Verify no existing work file → work_file_status

   - Use Bash `git branch --show-current` → branch_name
   - Check if `.claude/work/files/{branch_name}.yml` exists
   - If exists → STOP and tell user: "Work file already exists"
   - If not exists → continue to Step 2

2. PARSE: Extract requirement from $ARGUMENTS → requirement_data

   - If starts with "#": Use Bash `gh issue view` → {title, body, source}
   - Otherwise: Use as-is → {title: $ARGUMENTS, body: $ARGUMENTS}

3. DETECT: Use your finding-patterns skill with intent=detection:
   a. Pass parameters: {intent: "detection", pattern: from requirement_data}
   b. Extract detection results → pattern_found (boolean)
   c. DO NOT narrate - continue immediately to Step 4

4. ANALYZE: Use your analyst subagent:
   a. Pass requirement_data + pattern_found to analyst
   b. Analyst returns WORK_ITEMS + requirement_summary → analyst_output
   c. DO NOT narrate - continue immediately to Step 5

[... continues with similar pattern ...]

EXECUTION RULES:

- Complete steps 2-6 without stopping
- STOP only at step 6 for user approval
- DO NOT STOP at step 3 or 4 when skills return
```

**Analysis:**

- Complexity score: ~8 (8 steps, approval gate, loops, skill invocations affect flow) → **Full structure IS warranted**
- But notation is over-technical: CAPS + → + variables + function syntax + sub-steps + warnings
- Cognitive load: HIGH (must parse notation while understanding workflow)

**AFTER (organized natural language, appropriate structure):**

```markdown
**Your job: Initialize and execute Tier 2 development workflow for the current branch.**

## Setup and Validation

Get current branch name and check if work file already exists at `.claude/work/files/{branch_name}.yml`. If it exists, stop and tell user to use `/dev-resume` instead.

Parse the requirement source:

- If starts with "#" or "issue": fetch from GitHub (`gh issue view`)
- If ends with ".md": read from file
- Otherwise: use argument as-is

## Analysis

Find patterns in the requirement using finding-patterns skill (intent: detection). Note whether pattern was found.

Send requirement and pattern detection result to analyst subagent. Analyst returns work items organized by layer (backend/frontend/system) and requirement summary.

## Validation and Approval

Check completeness:

- MUST have frontend items if requirement mentions UI keywords (form, page, settings, button, interface, admin area)
- SHOULD have frontend if backend exists
- SHOULD have system tests if frontend exists

If issues found, present them to user and ask how to proceed (add missing items / cancel / continue as-is). Wait for user response.

If user cancels, stop here. If approved or no issues, continue.

## Work File Creation

Create work file using work-state-management skill (init operation). Pass:

- Branch name, requirement source, title, summary
- Work items (as adjusted by user)
- Tier: "tier2"
- Pattern found flag and estimated file count

If error occurs, stop with error message.

## Implementation Loop

Execute all work items in sequence:

**For each item:**

- Claim next item using work-state-management skill (claim operation)
- If no items remain, stop successfully
- Read work file to get full item details (id, description, tdd flag, category)

**Route based on tdd flag:**

- If `tdd: true`: Use tdd-workflow skill for RED-GREEN-REFACTOR cycle
- If `tdd: false`: Orchestrate implementation directly:
  - Analyze changes needed and implement
  - Use applicable skills/subagents when warranted
  - Run affected tests via validator subagent
  - Review code via check-quality subagent
  - Commit changes with descriptive message
  - Mark item complete using work-state-management skill

Continue until all items done, error occurs, or context limit approaching.

## Notes

- Work file must exist before starting implementation loop
- Each item completion updates work file state
- Can resume interrupted work with `/dev-resume`
- Branch name from setup used consistently throughout
```

**What changed:**

- ✅ Removed CAPS labels (CHECK, PARSE, DETECT → natural section headers)
- ✅ Removed → notation and variables (→ work_file_status, → requirement_data)
- ✅ Removed function call syntax (skill({params}))
- ✅ Removed sub-step enumeration (a/b/c → prose)
- ✅ Removed "DO NOT narrate" warnings
- ✅ Removed remote EXECUTION RULES section
- ✅ Added deliverable-first framing ("Your job:")
- ✅ Organized by logical phases (Setup, Analysis, Validation, etc.)
- ✅ Natural language throughout while preserving structure

**What stayed the same:**

- ✅ All 8 steps and their requirements
- ✅ Appropriate structure for complexity (still organized, not one paragraph)
- ✅ Execution flow and data dependencies
- ✅ Terminal conditions and branching logic
- ✅ Tool invocations and required parameters

**Cognitive load test:**

- Easier to understand? **YES** (read like instructions, not code)
- Easier to execute? **YES** (no stopping risk, clear flow)
- Preserves requirements? **YES** (all steps intact)
- Appropriate complexity? **YES** (structure still warranted for score ~8)

**Result: SUCCESSFUL OPTIMIZATION via Dimension 3 (notation simplification)**

---

## Part 4: Natural Language vs Technical Strategies

### Decision Framework

**For each optimization, ask:**

1. **What's the complexity score?** (determines structure level needed)
2. **What's the audience?** (LLM vs. human, technical vs. non-technical)
3. **Does technical notation add precision?** (prevents ambiguity vs. just looks technical)
4. **Cognitive load test**: Which version is easier to understand?

### When Natural Language Wins

#### Scenario 1: Simple Linear Tasks (Score ≤ 0)

**Characteristics:**

- 1-2 steps with obvious sequence
- No branching, approval gates, or terminal states
- Easily expressed with connectors ("then", "if", "when")

**Example:**

```markdown
# Technical (unnecessary structure)

1. Read configuration file
2. Update version number
3. Write file back

# Natural (better)

Read the config file, update the version number, and write it back.
```

**Why natural wins**: Enumeration adds no clarity. Sequence is trivial. Technical structure adds cognitive load for no benefit.

#### Scenario 2: Outcome-Focused Jobs (Deliverable-First Framing)

**Characteristics:**

- Clear deliverable stated upfront
- Steps are means to outcome, not the goal
- Flow is intuitive once outcome known

**Example:**

```markdown
# Technical (process-focused)

Execute this workflow:

1. Load data
2. Transform data
3. Generate report

# Natural (outcome-focused)

Your job: Generate the report.

Load the data, transform it as needed, and output the report.
```

**Why natural wins**: Deliverable framing + natural flow is clearer than procedural steps. Less cognitive load.

#### Scenario 3: Context-Rich Environments

**Characteristics:**

- Audience already has context
- Task is familiar pattern
- Over-specification would insult intelligence

**Example:**

```markdown
# Technical (over-specified)

1. Invoke Read tool with file_path parameter
2. Parse JSON content into object
3. Validate schema using validator
4. Return validated object

# Natural (appropriate)

Read and validate the JSON file.
```

**Why natural wins**: Audience knows how to read/validate JSON. Technical detail is noise. Lower cognitive load with natural version.

#### Scenario 4: LLM Audience (Most Prompts)

**Characteristics:**

- Prompt is for LLM execution (not human reading)
- LLM understands conversation better than symbols
- Technical notation doesn't add precision

**Example:**

```markdown
# Technical (hurts LLM execution)

1. READ: Load file → content
2. OPTIMIZE: Transform content → optimized
3. WRITE: Save optimized → done

# Natural (helps LLM execution)

Read the file, optimize the content, and write the result back.
```

**Why natural wins**: LLMs are language models. They excel at natural instructions, struggle with symbolic notation. Lower cognitive load = better execution.

### When Technical Strategies Win

#### Scenario 1: Complex Workflows (Score ≥ 3)

**Characteristics:**

- 5+ sequential steps
- Multiple approval gates or terminal states
- Control flow affects outcomes
- Skill/agent invocations affect decisions

**Example:**

```markdown
# Natural (insufficient structure)

Read the file, check dependencies, ask the user, optimize based on choice, and write back.

# Technical (appropriate structure - but natural notation)

Goal: Optimize file while handling dependencies

Tools: prompt-architecting, AskUserQuestion, grep

Workflow:

1. Read file and parse structure
2. Check dependencies if frontmatter exists
3. Present options and gather user preference
4. Optimize content based on selection
5. Write result with appropriate handling

If user cancels at step 3, stop here. Otherwise complete all steps.
```

**Why technical wins**: Multiple decision points, conditional flow, terminal states need explicit structure. **But note**: Structure is organized, notation is still natural (no CAPS, →, variables).

#### Scenario 2: Preventing Over-Generation

**Characteristics:**

- Task scope is unbounded
- Known tendency to over-elaborate
- Need hard constraints

**Example:**

```markdown
# Natural (insufficient constraints)

Write documentation for the API endpoints.

# Technical (appropriate constraints)

Document API endpoints. Format per endpoint:

## [METHOD] /path

Purpose: {1 sentence}
Params: {table}
Response: {JSON schema only}
Errors: {codes list}
Example: {curl + response}

DO NOT: Include HTTP theory, implementation details, or essays.
```

**Why technical wins**: Without template structure and exclusions, will generate 40-page guide instead of reference. Technical format serves clear purpose (API spec convention).

#### Scenario 3: Ambiguous Requirements

**Characteristics:**

- Multiple valid interpretations
- Need to constrain scope explicitly
- Success criteria unclear

**Example:**

```markdown
# Natural (ambiguous)

Help me understand the deployment process.

# Technical (clarified)

Document deployment process. Target: New dev deploys to staging in <10 min.

Structure: [Prerequisites - bullets] [Steps - numbered, 1 sentence each] [Verification] [Rollback - 2 sentences]

MAX 300 words.
```

**Why technical wins**: Template + constraint + success criteria clarifies what "help me understand" means. Technical structure reduces ambiguity.

#### Scenario 4: Standard Technical Conventions

**Characteristics:**

- Format has established convention (API specs, data schemas)
- Technical notation is standard
- Natural language would be less precise

**Example:**

```markdown
# Natural (loses precision)

Each endpoint should document the HTTP method, path, purpose, parameters with their types, responses, and errors.

# Technical (standard convention)

## [METHOD] /path

Purpose: {1 sentence}
Params: {name: type, required, description}
Response: {JSON schema}
Errors: {status codes}
```

**Why technical wins**: API documentation has standard format. Technical notation serves precision purpose.

### Decision Matrix

| Complexity Score | Audience          | Technical Precision Needed | Recommended Approach                              |
| ---------------- | ----------------- | -------------------------- | ------------------------------------------------- |
| ≤ 0              | LLM               | No                         | Natural Language                                  |
| ≤ 0              | LLM               | Yes                        | Natural + Template (minimal)                      |
| 1-2              | LLM               | No                         | Natural or Light Structure                        |
| 1-2              | LLM               | Yes                        | Light Structure + Template                        |
| 3-4              | LLM               | No                         | Organized Natural with Structure                  |
| 3-4              | LLM               | Yes                        | Moderate Structure + Templates                    |
| ≥ 5              | LLM               | No                         | Organized Natural with Full Structure             |
| ≥ 5              | LLM               | Yes                        | Full Structure + Templates (but natural notation) |
| Any              | Human (technical) | Yes                        | Technical notation acceptable                     |

**Key principle**: Structure level follows complexity score. Notation style (natural vs. technical) follows cognitive load test.

**Override conditions:**

- **Unbounded scope** → Technical constraints (even if simple steps)
- **Already optimal** → Neither (leave alone)
- **Callable entity description** → Preserve existing pattern
- **Standard technical convention** → Technical format (API specs, schemas)
- **Over-technical ceremony** → Simplify to organized natural

---

## Part 5: Callable Entity Preservation

### The Additive Pattern

**Format:**

```
[What it does] when [contextual condition]. When user says "[trigger1]", "[trigger2]"[, or [integration point]].
```

**Two layers:**

1. **Semantic (contextual)**: Describes situations that warrant usage
2. **Pattern-matching (triggers)**: Literal phrases users say

Both layers are required for effective model-invocation.

### Optimization Rules for Callable Entities

#### Rule 1: Preserve Both Layers

**Bad optimization:**

```markdown
# Before

description: Explores codebases when search spans multiple locations or naming is ambiguous. When user says "how does X work?", "find files matching", or when searches need 3+ rounds.

# Over-optimized (WRONG - lost both layers)

description: Explores codebases for complex searches
```

**Lost**: Contextual conditions (multiple locations, ambiguous naming), trigger phrases, threshold (3+ rounds)

**Correct optimization:**

```markdown
# Minimal acceptable

description: Explores codebases when search spans multiple locations or naming is ambiguous. When user says "how does X work?", "find files", or searches need 3+ attempts.
```

**Preserved**: Both contextual conditions AND trigger phrases, slight reduction in verbosity only (10-20% max)

#### Rule 2: Add Missing Layers

**Context-only (missing triggers):**

```markdown
# Before

description: Reviews code for security vulnerabilities and bugs when quality assessment needed

# Add triggers

description: Reviews code for security vulnerabilities and bugs when quality assessment needed. When user says "review this code", "check for bugs", "analyze security".
```

**Triggers-only (missing context):**

```markdown
# Before

description: Use when user says "optimize this prompt" or "make concise"

# Add context

description: Optimizes verbose prompts when content risks over-generation or needs density improvement. When user says "optimize this prompt", "make concise", "reduce verbosity".
```

#### Rule 3: Strengthen Delegation Signals for Subagents

**Passive:**

```markdown
description: Can analyze codebases when searches are complex
```

**Active (PROACTIVELY):**

```markdown
description: Use PROACTIVELY for codebase exploration when searches span 3+ files or user asks structural questions ("how does X work?")
```

**Critical (MUST BE USED):**

```markdown
description: MUST BE USED for security audits when user mentions vulnerabilities, exploits, or security review
```

#### Rule 4: Add Integration Points

**Without:**

```markdown
description: Optimizes prompts when content is verbose. When user says "optimize this".
```

**With integration:**

```markdown
description: Optimizes prompts when content is verbose. When user says "optimize this", "make concise", or before invoking skill-generator.
```

### Detection in Step 2 Analysis

**Callable entity check:**

- Is this a `description` field for skill/agent/command?
- Does it have contextual "when" conditions? (YES/NO/VAGUE)
- Does it have trigger phrases (quoted literals)? (YES/NO/WEAK)
- Does it have delegation signals if subagent? (YES/NO/N/A)
- Does it have integration points? (YES/NO/N/A)
- **State**: "Callable entity: [yes/no]. Context: [present/vague/missing]. Triggers: [present/weak/missing]. Structure: [complete/context-only/triggers-only/missing]."

**If callable entity detected:**

- REQUIRED strategy: Callable Entity Preservation
- Target: Preserve both layers, add missing layer if incomplete
- Reduction target: Minimal (10-20% max)
- Focus: Clarity of invocation, not conciseness

---

## Part 6: Avoiding Misleading Stopping Points

### The Problem

Certain prompting patterns create **false completion boundaries** where LLMs stop execution prematurely, treating intermediate steps as final deliverables.

**Root cause**: Over-technical notation creates procedural boundaries that signal completion.

### Patterns That Create Stopping Risk

#### Anti-Pattern 1: CAPS + → + Variables (Highest Risk)

```markdown
# HIGH RISK (creates stopping points)

1. READ: Load file → content
2. OPTIMIZE: Run skill → optimized_content
3. WRITE: Save optimized_content → done

# Why risky:

- Each step feels like complete function with return value
- Step 2 produces "optimized_content" which looks like artifact
- → notation creates procedural boundary
- CAPS labels create discrete units of work
```

**When skill returns at Step 2, LLM treats step as complete and stops.**

This is **Dimension 3 problem (over-technical notation)**.

#### Anti-Pattern 2: Explicit Actor Invocations

```markdown
# HIGH RISK

2. Use your prompt-architecting skill to optimize the content
3. Extract the "Optimized Prompt" section from the skill output
4. Write the result to the file

# Why risky:

- Creates nested execution context (workflow contains skill execution)
- Explicit extraction step reinforces output boundary
- When skill completes, step feels complete
```

#### Anti-Pattern 3: Remote EXECUTION RULES

```markdown
# HIGH RISK

[Steps 1-4...]

## EXECUTION RULES

- Complete all steps
- Step 3 is not the final deliverable
- Continue to step 4 after step 3

# Why risky:

- Can't compete with immediate psychological closure at step 3
- Defensive language actually reinforces stop-awareness
- Remote section is read after steps, can't override in-the-moment completion sense
```

#### Anti-Pattern 4: Defensive Stop-Awareness Commentary

```markdown
# HIGH RISK (creates the problem it tries to prevent)

3. OPTIMIZE: Run skill → optimized
   → DO NOT STOP - this is NOT the end
   → Continue immediately to Step 4

CRITICAL REMINDERS:

- Skill output is NOT completion signal
- If you find yourself stopping at Step 3, you failed

# Why risky (Ironic Process Theory):

- "DO NOT STOP" makes LLM consider stopping
- "This is NOT the end" reinforces ending as possibility
- Describing failure mode normalizes it
- Creates decision point: "Should I stop here?" (answer: sometimes yes)
```

### Patterns That Prevent Stopping

#### Safe Pattern 1: Deliverable-First Natural Language

```markdown
# SAFE (natural continuation)

Your job: Optimize the file and write the improved version back.

Read the file, check for frontmatter. If frontmatter exists, search for dependencies and ask how to proceed. Optimize the content using provided guidance. Write the result back to the file. The file edit is the deliverable.
```

**Why safe:**

- Job framing establishes ultimate outcome upfront
- Natural connectors ("if", "then") create flow
- Completion criterion clear and proximate
- No ceremony creating false boundaries
- No technical notation signaling completion

#### Safe Pattern 2: Organized Natural with Appropriate Structure

```markdown
# SAFE (appropriate structure, natural notation)

**Your job: Write optimized content to $1.**

## Process

Read file and check for frontmatter. If frontmatter exists, search for dependencies.

When dependencies found, ask user how to proceed:

- Preserve frontmatter unchanged
- Modify and update dependencies
- Cancel

If user cancels, stop here.

Optimize content based on user selection. Write result to $1. The file edit completes this task.
```

**Why safe:**

- Deliverable statement opens
- Organized sections without CAPS/→/variables
- Completion criterion immediately after process
- Terminal condition integrated naturally
- No defensive commentary
- Natural language throughout

#### Safe Pattern 3: Goal + Capabilities (Complex Tasks)

```markdown
# SAFE (for complex workflows)

Goal: Optimize prompt file while handling dependencies appropriately

Required capabilities: prompt-architecting skill, AskUserQuestion, grep

Workflow:

1. Read and parse file structure
2. Check dependencies if frontmatter exists
3. Present options and gather user preference
4. Optimize content based on selection
5. Write result with appropriate handling

If user cancels at step 3, stop here. Otherwise complete all steps. The file edit is the final deliverable.
```

**Why safe:**

- Goal statement establishes outcome
- Capabilities declared separately (not in steps)
- Numbered steps use natural language (not CAPS + → + variables)
- Outcome-focused descriptions (not actor invocations)
- No procedural notation
- Completion criterion proximate

### Transformation Guide

**If input contains stopping risk patterns:**

1. **Calculate complexity score** (determines structure level needed)
2. **Identify notation problems** (CAPS, →, variables, warnings)
3. **Select safe pattern:**
   - Score ≤ 0: Natural language
   - Score 1-2: Simple organized sections
   - Score 3-4: Organized natural with appropriate structure
   - Score ≥ 5: Goal + Capabilities + organized workflow
4. **Remove all ceremony:**
   - Strip CAPS labels → natural section headers or action verbs
   - Remove → notation and variables → implicit data flow
   - Delete explicit parsing steps → consolidate
   - Convert "Run skill" → "Optimize content" (outcome not actor)
5. **Make completion proximate:**
   - Put completion criterion inline or immediately after workflow
   - Never in remote section
6. **Eliminate stop-awareness:**
   - Zero "DO NOT STOP" warnings
   - Zero meta-commentary about failure
   - Zero CRITICAL REMINDERS sections

**The core fix**: **Simplify notation (Dimension 3)** while **preserving appropriate structure (Dimension 2)**.

---

## Part 7: Strategy Combination Principles

### Rule 1: Maximum 3 Strategies

**Why**: More strategies = conflicting directions = confusion

**Bad (5 strategies - conflict):**

- Constraint-Based (MAX 300w)
- Template-Based ([Purpose][Workflow][Example])
- Decomposition (break into 6 sub-tasks)
- Execution Flow Control (formal workflow with state management)
- Progressive Disclosure (move details to references/)

**Conflict**: Template wants specific sections; Decomposition wants sub-tasks; EFC wants workflow steps. Can't do all three.

**Good (2 strategies - complement):**

- Constraint-Based (MAX 300w)
- Template-Based ([Purpose][Workflow][Example])

**Complement**: Both focus on structure and boundaries. No conflict.

### Rule 2: Match Strategies to Complexity

| Complexity | Primary Strategy                    | Optional Secondary                 | Avoid                               |
| ---------- | ----------------------------------- | ---------------------------------- | ----------------------------------- |
| ≤ 0        | Natural Language Reframing          | Constraint-Based                   | EFC, Decomposition, Template        |
| 1-2        | Template-Based or Output Formatting | Constraint-Based                   | Full EFC (use light structure)      |
| 3-4        | Organized Natural with Structure    | Template, Constraint               | Heavy formality, defensive warnings |
| ≥ 5        | Goal + Capabilities Pattern         | Decomposition, Directive Hierarchy | Over-technical notation             |

**New addition**: Technical → Natural Transformation (applies across all complexity levels when notation is over-technical)

### Rule 3: Strategy Compatibility Matrix

| Strategy                   | Compatible With                      | Conflicts With                       |
| -------------------------- | ------------------------------------ | ------------------------------------ |
| Natural Language Reframing | Constraint-Based, Negative Prompting | EFC, Decomposition, Template         |
| Constraint-Based           | Most strategies                      | None (universally compatible)        |
| Template-Based             | Constraint-Based, Output Formatting  | Decomposition (different structures) |
| EFC (organized natural)    | Decomposition, Directive Hierarchy   | Heavy technical notation             |
| Decomposition              | EFC, Directive Hierarchy             | Template, Natural Language           |
| Progressive Disclosure     | Any (orthogonal concern)             | None                                 |
| Negative Prompting         | Any (orthogonal concern)             | None                                 |
| Technical → Natural        | Any (orthogonal concern)             | None (often combined with others)    |

### Rule 4: One Primary Strategy

**Primary strategy**: Addresses the main optimization need

**Secondary strategies**: Address specific bloat risks or edge cases

**Example:**

- **Primary**: Technical → Natural Transformation (main issue: over-technical notation)
- **Secondary**: None needed (notation was the problem)

**Another example:**

- **Primary**: Template-Based (main issue: no structure)
- **Secondary**: Negative Prompting (specific bloat: framework comparisons)
- **Universal**: Constraint-Based (always useful for hard limits)

### Rule 5: Avoid Redundant Strategies

**Bad (redundant):**

- Template-Based (provides structure)
- Output Formatting (also provides structure)
- Decomposition (also provides structure)

**Why bad**: All three do similar things. Choose one.

**Good (complementary):**

- Template-Based (provides structure)
- Constraint-Based (provides length limits)
- Technical → Natural (simplifies notation)

**Why good**: Each addresses different dimension. Complementary, not redundant.

### Rule 6: Technical → Natural Often Solves Multiple Problems

**Observation**: Simplifying over-technical notation often addresses:

- Dimension 3: Notation clarity
- Stopping risk (Part 6)
- Cognitive load reduction

**Implication**: When over-technical notation detected, Technical → Natural Transformation may be sufficient optimization. Don't over-optimize by adding more strategies.

**Example:**

```markdown
# Input (over-technical + stopping risk)

1. READ: Load → content
2. OPTIMIZE: Run skill → optimized
3. WRITE: Save → done

# After Technical → Natural (sufficient)

Read the file, optimize with the skill, and write the result back.

# Don't add more strategies (would be over-optimization):

❌ Don't add: Decomposition (already has structure)
❌ Don't add: Template (natural language is clearer)
✅ Could add: Constraint-Based (MAX 300w) if unbounded scope
```

---

## Part 8: Trustworthiness Criteria

### Definition

**Trustworthy optimization** means the optimized prompt is:

1. **Clearer** than original (reduced cognitive load)
2. **Preserves intent and requirements** (all MUST/SHOULD/MAY intact)
3. **Appropriate for complexity level** (right structure, right notation)
4. **Doesn't introduce new problems** (no stopping risk, lost triggers, etc.)
5. **Results in better LLM execution** (more reliable, less ambiguous)

### Pre-Optimization Checklist

Before optimizing, verify:

- [ ] **Bloat is real**: Not just "different style preference"
- [ ] **Optimization would help**: Not already at right complexity level
- [ ] **No special preservation needs**: Not callable entity description with correct structure
- [ ] **Clear improvement path**: Know which dimensions need work and why
- [ ] **No over-optimization risk**: Not introducing complexity where none needed
- [ ] **Cognitive load will decrease**: Optimized version will be easier to understand

### Post-Optimization Checklist

After generating optimized version, verify:

- [ ] **Clarity improved**: Optimized version is easier to understand (cognitive load test)
- [ ] **Intent preserved**: Core meaning unchanged, all requirements intact
- [ ] **Appropriate structure**: Matches complexity score
- [ ] **Appropriate notation**: Natural unless technical serves clear purpose
- [ ] **No new problems**: Didn't introduce stopping points, lose triggers, create ambiguity
- [ ] **Executable**: Can imagine LLM following this successfully
- [ ] **Reduction appropriate**: 40-50% for agents/workflows, 60%+ for docs OK
- [ ] **Strategy count**: 1-3 strategies, complementary not conflicting

### The Cognitive Load Test

**Ask yourself**: If you had to follow this prompt, which version requires less mental effort to understand?

**Original:**

```
I need you to help me optimize this prompt file. First read the file that the user gives you. Then you should check if it has front matter with a description field. If it does, search through the codebase to see if other files reference this description because that would mean we have dependencies. After that, use your prompt-architecting skill to make the content better and more concise. Then show the user what you came up with and ask if they want to proceed. If they say yes, write the file back. Make sure you handle the front matter correctly depending on what the user chose.
```

**Over-optimized (too technical):**

```
Execute this 7-step procedure completely:
1. READ: Load($1) → content
2. PARSE: Extract(content) → fm, body
3. DEPS: Grep(fm.description) → dep_files
4. ASK: AskUserQuestion(modes) → choice
5. OPTIMIZE: Skill(body, choice) → optimized
6. RECON: Merge(fm, optimized, choice) → final
7. WRITE: Save(final, $1) → done

EXECUTION RULES:
- STOP only at step 4 (user input)
- Continue to step 7 (terminal state)
- DO NOT STOP at step 5 (skill return)
```

**Appropriately optimized (organized natural):**

```
Your job: Optimize the file at $1 and write it back while handling dependencies.

Read the file and check for frontmatter. If frontmatter exists with description field, search other prompt files for references to that description. When dependencies found, ask user how to proceed: preserve frontmatter unchanged, modify and update dependencies, or cancel. If user cancels, stop here.

Optimize the content based on user selection. Write the result back to $1. The file edit is the deliverable.
```

**Cognitive load comparison:**

- **Original**: 200 words, embedded reasoning, unclear structure → **MEDIUM-HIGH load**
- **Over-optimized**: Intimidating notation, must parse syntax, creates stopping risk → **HIGH load**
- **Appropriate**: Clear prose, organized flow, right complexity level → **LOW load**

**Winner**: Appropriately optimized (lowest cognitive load while preserving all requirements)

### The Intent Preservation Test

**Required elements from original:**

- Must read file ✓
- Must check frontmatter ✓
- Must search dependencies ✓
- Must ask user ✓
- Must optimize content ✓
- Must write file ✓
- Must handle frontmatter correctly ✓

**All preserved?** Yes.

**Could LLM execute successfully?** Yes.

**Is it clearer than original?** Yes (cognitive load lower).

**Trustworthy optimization**: ✓

### The Regression Test

**Question**: Would the optimized version execute as reliably as a known-working version?

**Known working patterns (empirically tested):**

- Deliverable-first framing
- Natural language or organized natural with structure
- No CAPS/→/variables
- Inline completion criteria
- No defensive warnings

**Optimized version has these?**

- If YES → Likely trustworthy
- If NO → High regression risk, reconsider optimization

### When in Doubt

**Conservative principle**: When uncertain if optimization would help or harm, make smaller changes.

**Incremental optimization:**

1. Remove obvious bloat (adjectives, meta-discussion, filler)
2. Add hard constraints (MAX word count)
3. Test: Is this enough? If yes, stop here.
4. If more needed, address structure mismatch (add/remove complexity)
5. Test: Is this enough? If yes, stop here.
6. If more needed, simplify notation (technical → natural)
7. Test: Is this enough? If yes, stop here.
8. Only if still insufficient, add one secondary strategy

**Never optimize to "show off strategies"**. Optimize only to solve real problems.

---

## Part 9: Integration with Existing Skill

### Updates to SKILL.md

#### Update Step 2 (Analyze the Task)

```markdown
### Step 2: Analyze the Task

**FIRST: Safety checks (prevent harmful optimization)**

Check if content should NOT be optimized:

- Already optimal pattern? (deliverable-first + natural/appropriate structure + right complexity + appropriate notation)
- Callable entity description at correct structure? (context + triggers present)
- Agent/workflow at 40-50% of bloated version with specificity intact?
- Technical notation serving clear purpose? (API specs, standard conventions, precision needed)
- User requests preservation?

**If any YES**: STATE "Optimization not recommended: [reason]" and use mode=consult to provide analysis only.

**SECOND: Dimensional analysis (if optimization appropriate)**

Evaluate each dimension:

**Dimension 1 (Verbosity):**

- Bloat indicators present? (adjective-heavy, scope inflation, vague quality statements, meta-discussion, filler, repetition)
- Current word count vs. ideal for task? (>2x ideal = bloat)
- State: "Verbosity: [bloated/concise/appropriate]. Reduction needed: [yes/no]"

**Dimension 2 (Structure):**

- Complexity score calculation (using formula from SKILL.md)
- Current structure level: [none/minimal/moderate/full]
- Appropriate structure level for score: [natural/light/moderate/full]
- Structure mismatch? [over-structured/under-structured/appropriate]
- State: "Complexity score: [X]. Current structure: [level]. Needed: [level]. Mismatch: [yes/no]"

**Dimension 3 (Notation):**

- Technical notation assessment:
  - CAPS labels as action markers? (CHECK:, PARSE:, etc.)
  - → notation for data flow? (→ variable_name)
  - Variable naming conventions? (work_file_status, requirement_data)
  - Function call syntax? (tool({params}))
  - Sub-step enumeration? (a/b/c)
  - Defensive meta-instructions? ("DO NOT narrate")
- Count indicators (3+ = over-technical)
- Does notation serve precision purpose? (API specs, schemas, standard conventions)
- Cognitive load test: Does notation make it easier or harder to understand?
- State: "Technical notation: [X indicators]. Purpose: [precision/ceremony]. Cognitive load: [helps/hurts/neutral]. Assessment: [over-technical/appropriate]"

**THIRD: Semantic analysis** (core job understanding)

- What is core job in one sentence?
- Can it be expressed with natural connectors? (Test: "Do X, then Y, when Z")
- If YES and complexity score ≤ 0: Strong candidate for natural language

**FOURTH: Callable entity check** (if description field)

- Contextual "when" conditions: present/vague/missing
- Trigger phrases (quoted literals): present/weak/missing
- Delegation signals if subagent: present/missing/N/A
- Integration points: present/missing/N/A
- Structure: complete/context-only/triggers-only/missing

**FIFTH: Workflow pattern detection** (if skill/agent invocations)

- High-risk stopping patterns present? (CAPS + → + variables + remote rules + warnings)
- Classification: high-risk / optimal / standard
- Stopping risk: yes/no
- Note: High-risk patterns are Dimension 3 problem (over-technical notation)

**SIXTH: Target length and bloat risks**

- Calculate optimal word/line count based on complexity and output type
- Identify specific bloat risks (edge cases, theoretical coverage, defensive docs, etc.)

**SEVENTH: Architecture compliance** (if architecture_reference provided)

- Compare input structure to architecture requirements
- Identify missing required sections
- Identify structural misalignments
- State: "Architecture: [compliant/partial/non-compliant]. Missing: [list]. Misaligned: [list]."

**OUTPUT: Comprehensive analysis stating which dimensions need optimization and why**
```

#### Update Step 3 (Select Strategies)

```markdown
### Step 3: Select Strategies

**MANDATORY EXCLUSIONS (based on Step 2 safety checks):**

- If already optimal: STOP - recommend no optimization
- If complexity score ≤ 0: NEVER use EFC, Decomposition, or Template-Based
- If callable entity: MUST use Callable Entity Preservation, MAX 1 additional strategy
- If technical notation serves precision purpose: PRESERVE notation, optimize other dimensions only

**MANDATORY SELECTIONS (based on Step 2 dimensional analysis):**

**For Dimension 1 (Verbosity problems):**

- MUST select: Constraint-Based (hard word limits)
- SHOULD select: Negative Prompting (if specific bloat patterns identified)
- MAY select: Progressive Disclosure (if complex topic with separable details)

**For Dimension 2 (Structure mismatch):**

- If over-structured (score ≤ 0 but has formal structure):
  - MUST select: Natural Language Reframing
- If under-structured (score ≥ 3 but vague prose):
  - Score 3-4: Moderate structure (organized natural, no heavy formality)
  - Score ≥ 5: Goal + Capabilities pattern
  - MAY select: Decomposition, Directive Hierarchy

**For Dimension 3 (Over-technical notation):**

- If over-technical detected (3+ indicators, cognitive load hurts):
  - MUST select: Technical → Natural Transformation
  - This often solves stopping risk simultaneously
  - May be SUFFICIENT optimization (don't over-optimize)

**For Callable Entities (detected in Step 2):**

- MUST select: Callable Entity Preservation
- Focus on preserving/adding both layers (context + triggers)

**For High-Risk Workflows (detected in Step 2):**

- MUST select: Technical → Natural Transformation (removes stopping risk)
- Preserve appropriate structure level (based on complexity score)
- Remove ceremony (CAPS, →, variables, warnings)

**STRATEGY COUNT LIMIT: 1-3 strategies max**

- 1 strategy: Simple reframing or notation simplification
- 2 strategies: Most common (address 2 dimensions or primary + constraint)
- 3 strategies: Complex only (rarely needed)

**NEVER exceed 3 strategies** (over-optimization risk)

**COMPLEMENTARY CHECK:**

- Verify selected strategies don't conflict (see compatibility matrix in STRATEGIES.md)
- If conflict detected, choose most important strategy and drop conflicting ones
```

#### Update Step 4 (Generate Output)

```markdown
### Step 4: Generate Output

Based on mode:

**IF mode=consult:**

- DO NOT generate optimized prompt
- Output analysis, recommended strategies, and optimization potential
- If architecture provided, include architecture compliance assessment
- Use consult output format

**IF mode=optimize (default):**

**Primary principle**: Reduce cognitive load while preserving intent.

**Apply selected strategies based on dimensions:**

**For Dimension 1 (Verbosity):**

- Remove adjectives and quality statements
- Set hard word/line limits
- Use template structure to bound scope
- Exclude known bloat patterns explicitly
- Target: 60%+ reduction for docs OK, 40-50% for agents/workflows

**For Dimension 2 (Structure):**

Match structure to complexity score:

- **Score ≤ 0 (Natural language)**:

  - Rewrite as clear prose with connectors ("then", "if", "when")
  - Avoid enumeration unless truly necessary
  - Embed conditionals inline naturally
  - Example: "Read the file, optimize content, and write back"

- **Score 1-2 (Light structure)**:

  - Simple numbered steps or sections without heavy formality
  - Natural language throughout
  - No CAPS labels, no → notation
  - Example: "1. Read file 2. Optimize 3. Write result"

- **Score 3-4 (Organized natural with structure)**:

  - Logical sections or phases (Setup, Analysis, Execution, etc.)
  - Natural language within structured organization
  - NO CAPS/→/variables
  - Completion criterion inline or immediately after
  - Example: See "appropriately optimized" /dev-start in Part 3

- **Score ≥ 5 (Goal + Capabilities + organized workflow)**:
  - Goal statement (ultimate outcome upfront)
  - Capabilities declaration (tools/skills needed)
  - Organized workflow with natural language
  - Clear terminal conditions
  - STILL use natural notation (no CAPS/→/variables)

**For Dimension 3 (Over-technical notation):**

Remove ceremonial technical notation:

- CAPS labels → natural section headers or action verbs
- → notation → implicit data flow or prose
- Variable names → eliminate or minimize
- Function call syntax → natural tool mentions
- Sub-step enumeration → consolidate to prose
- Defensive warnings → remove entirely (trust structure)
- Remote EXECUTION RULES → integrate inline or remove

While preserving:

- Appropriate structure level (based on complexity score)
- All requirements and dependencies
- Tool invocations (mentioned naturally)
- Terminal conditions (integrated naturally)

**For Callable Entities:**

- Preserve both contextual "when" AND trigger phrases
- Add missing layer if incomplete
- Minimal optimization (10-20% max)
- Focus on invocation clarity

**General optimization:**

- Sets hard word/line limits (Constraint-Based)
- Specifies structure (Template-Based or Output Formatting if applicable)
- Excludes known bloat patterns (Negative Prompting if applicable)
- Embeds selected strategies naturally into instructions

**If architecture_reference provided:**

- Refactor content to align with architecture requirements
- Add missing required sections
- Preserve required patterns
- Optimize content WITHIN architectural structure

**FINAL SAFETY CHECK before returning:**

Verify optimized version:

- [ ] Clarity test: Is it clearer than original? (cognitive load lower)
- [ ] Intent test: Core requirements preserved?
- [ ] Complexity match: Structure appropriate for score?
- [ ] Notation appropriate: Natural unless technical serves precision purpose?
- [ ] No new problems: No stopping points, lost triggers, introduced ambiguity?
- [ ] Executable: Would LLM follow this successfully?
- [ ] Reduction appropriate: 40-50% agents/workflows, 60%+ docs
- [ ] Strategy count: 1-3, complementary

**If any check FAILS**: Revise optimization or recommend consult mode only.
```

### New Reference Files

#### Create OPTIMIZATION-SAFETY-GUIDE.md

This document (comprehensive-spec-v2-FINAL.md) should be saved as:
`/Users/brandoncasci/.claude/skills/prompt-architecting/references/OPTIMIZATION-SAFETY-GUIDE.md`

#### Update STRATEGIES.md

Add to top:

```markdown
# IMPORTANT: Read Safety Guide First

Before selecting strategies, read OPTIMIZATION-SAFETY-GUIDE.md to understand:

- When NOT to optimize
- Three dimensions of optimization (verbosity, structure, notation)
- Over-optimization risks
- Natural language vs technical strategy decision criteria
- Callable entity preservation requirements
- Strategy combination limits (1-3 max)
- Cognitive load as the core metric

This ensures trustworthy optimization that reduces cognitive load while preserving intent.
```

Add Strategy #15:

```markdown
## 15. Technical → Natural Transformation

**When**: Over-technical notation detected (3+ indicators) and cognitive load test shows notation hurts understanding

**Indicators**:

- CAPS labels as action markers (CHECK:, PARSE:, VALIDATE:)
- → notation for data flow (→ variable_name)
- Variable naming conventions (work_file_status, requirement_data)
- Function call syntax (tool({params}))
- Sub-step enumeration (a/b/c when prose would work)
- Defensive meta-instructions ("DO NOT narrate", "continue immediately")

**Pattern**: Keep appropriate structure level (based on complexity score), simplify notation to organized natural language

**Transformation**:

- CAPS labels → natural section headers or action verbs
- → notation → implicit data flow or prose
- Variable names → eliminate or minimize
- Function call syntax → natural tool mentions
- Sub-step enumeration → consolidate to prose
- Defensive warnings → remove (trust structure)

**Example**:

Before (over-technical):
```

1. CHECK: Verify status → work_file_status
   a. Use Bash `git branch` → branch_name
   b. Check if file exists
   c. DO NOT proceed if exists
2. PARSE: Extract data → requirement_data

```

After (organized natural):
```

## Setup

Get current branch name and check if work file already exists. If it exists, stop and tell user to use /dev-resume.

Parse the requirement source...

```

**Why this works**:
- Preserves appropriate structure (complexity still warrants organization)
- Removes ceremonial notation that creates cognitive load
- Eliminates stopping risk (no CAPS/→/variables creating boundaries)
- Natural language is clearer for LLM audiences
- Reduces cognitive load significantly

**Often solves multiple problems simultaneously**:
- Dimension 3 (notation clarity)
- Stopping risk (Part 6)
- Cognitive load reduction

**May be sufficient optimization alone** - don't over-optimize by adding more strategies.

**See OPTIMIZATION-SAFETY-GUIDE.md Part 3 for detailed examples and Part 6 for stopping risk relationship.**
```

#### Update ANTI-PATTERNS.md

Add section:

```markdown
## Pattern 8: Destroying Callable Entity Triggers

### ❌ Over-optimized
```

# Before (complete)

description: Reviews code for security, bugs, performance when quality assessment needed. When user says "review this code", "check for bugs", "analyze security".

# Over-optimized (WRONG - lost triggers)

description: Code review assistant

```

### ✅ Correct
```

# Minimal acceptable optimization

description: Reviews code for security, bugs, performance when quality assessment needed. When user says "review code", "check bugs", "analyze security".

```

**Why**: Trigger phrases are functional pattern-matching signals for model-invocation, not decorative examples. Preserve both contextual "when" AND literal trigger phrases.

## Pattern 9: Over-Technical Notation Creating Cognitive Load

### ❌ Over-technical
```

Execute this workflow:

1. READ: Load file → content
2. PARSE: Extract(content) → {fm, body}
3. OPTIMIZE: Run skill(body) → optimized
   a. Pass parameters: {content: body, mode: "optimize"}
   b. Extract result → optimized
   c. DO NOT STOP - continue to step 4
4. WRITE: Save(optimized) → done

EXECUTION RULES:

- DO NOT STOP at step 3 when skill returns

```

### ✅ Organized natural
```

Your job: Optimize the file and write it back.

Read the file and parse structure. Optimize the content using the skill. Write the result back. The file edit is the deliverable.

```

**Why**: Technical notation (CAPS + → + variables + function syntax + warnings) increases cognitive load and creates stopping risk. Organized natural language with appropriate structure is clearer for LLM audiences.

**See OPTIMIZATION-SAFETY-GUIDE.md Part 3 and Part 6 for detailed analysis.**
```

#### Update ADVANCED-ANTI-PATTERNS.md

Add at top:

```markdown
# Advanced Anti-Patterns: Workflow & Agent Optimization

**CRITICAL**: For detailed stopping point analysis, see `/Users/brandoncasci/.claude/tmp/workflow-optimization-spec.md`

**CRITICAL**: For safety guidelines and dimensional analysis, see `OPTIMIZATION-SAFETY-GUIDE.md`

**KEY INSIGHT**: Most stopping risk patterns are caused by over-technical notation (Dimension 3). Simplifying notation while preserving appropriate structure solves the problem.

[... existing content ...]
```

---

## Part 10: Testing Requirements

### Test Suite

Create comprehensive test cases covering all dimensions:

#### Test 1: Already Optimal (Should NOT Optimize)

**Input:**

```markdown
Your job: Optimize the file at $1 and write it back.

Read the file, check for frontmatter. If frontmatter exists, search for dependencies and ask how to proceed. Optimize the content. Write the result back. The file edit is the deliverable.
```

**Expected**:

- Dimensional analysis: Verbosity OK, structure OK, notation OK
- Conclusion: "Already optimal - deliverable-first + natural language + appropriate complexity. No optimization needed."

**If optimization attempted, would make it worse.**

#### Test 2: Dimension 1 (Verbosity) - Compress Bloat

**Input:**

```markdown
I need you to create comprehensive, robust, production-ready documentation that covers absolutely all aspects of user authentication in our system. This should include detailed explanations of how the entire system works, what technologies we're using, best practices for implementation, common pitfalls to avoid, security considerations, edge cases, error handling strategies, and example code showing different use cases. Make sure it's thorough and covers everything a developer might possibly need to know.
```

**Expected**:

- Dimension 1: Bloated (adjective-heavy, scope inflation, >2x ideal length)
- Dimension 2: Structure appropriate (low complexity, just needs constraints)
- Dimension 3: Notation appropriate (natural language, no ceremony)
- Strategy: Constraint-Based + Output Formatting + Negative Prompting
- Reduction: 60%+ OK (documentation)

**Output:**

```markdown
Write auth docs. Structure: [Setup - 100w] [Usage - 150w] [Error handling - 100w] [One example - code only]. MAX 400 words. Audience: Mid-level dev familiar with JWT. DO NOT: Security theory, framework comparisons, "best practices" sections.
```

#### Test 3: Dimension 2 (Structure) - Over-Structured

**Input:**

```markdown
Execute this 3-step workflow completely:

1. Read the configuration file at the specified path
2. Update the version number field to the new value provided
3. Write the modified file back to the same path

EXECUTION RULES:

- Complete all steps in sequential order
- Stop only when all steps completed
- Ensure proper error handling at each step
```

**Expected**:

- Dimension 1: Verbosity OK
- Dimension 2: Over-structured (score ≤ 0, but has formal workflow)
- Dimension 3: Some ceremony (EXECUTION RULES section)
- Strategy: Natural Language Reframing
- Complexity score: -1 (2 trivial steps)

**Output:**

```markdown
Read the config file, update the version number, and write it back.
```

#### Test 4: Dimension 3 (Notation) - Over-Technical

**Input:**

```markdown
Execute this workflow completely:

1. READ: Load file → content
2. OPTIMIZE: Run skill → optimized
   a. Call prompt-architecting skill
   b. Extract result → optimized
   c. DO NOT STOP - continue to Step 3
3. WRITE: Save optimized → done

EXECUTION RULES:

- Step 2 is NOT terminal state
- Continue to step 3 after skill returns
```

**Expected**:

- Dimension 1: Verbosity OK
- Dimension 2: Structure appropriate for complexity (3 steps = score ~1)
- Dimension 3: Over-technical (CAPS + → + variables + sub-steps + warnings)
- Stopping risk: YES (high risk pattern)
- Strategy: Technical → Natural Transformation
- Complexity score: 1 (simple workflow)

**Output:**

```markdown
Your job: Optimize the file and write it back.

Read the file, optimize with the skill, and write the result back. The file edit is the deliverable.
```

#### Test 5: Dimension 3 (Complex) - High Complexity with Over-Technical Notation

**Input:** (Full /dev-start command from Part 3)

**Expected**:

- Dimension 1: Verbosity appropriate
- Dimension 2: Structure appropriate (score ~8 = full structure warranted)
- Dimension 3: Over-technical (many ceremony indicators)
- Stopping risk: YES (CAPS + → + variables + warnings)
- Strategy: Technical → Natural Transformation (keep structure, simplify notation)
- Complexity score: 8 (must preserve structure)

**Output:** (Organized natural /dev-start from Part 3)

**Key**: Structure level preserved (still organized sections), but notation simplified (no CAPS/→/variables)

#### Test 6: Callable Entity Description (Preserve Triggers)

**Input:**

```markdown
description: This skill really helps you when you need to optimize prompts and make them better and more concise and structured. It's especially useful when prompts are getting too long or verbose or could benefit from better organization.
```

**Expected**:

- Callable entity: YES
- Dimension 1: Some verbosity (filler like "really helps", "especially useful")
- Context present: VAGUE ("when you need to optimize")
- Triggers: MISSING (no quoted literal phrases)
- Strategy: Callable Entity Preservation
- Reduction: Minimal (10-20% max)

**Bad output:**

```markdown
description: Optimizes prompts
```

_Lost both context and triggers_

**Good output:**

```markdown
description: Optimizes verbose prompts when content risks over-generation or needs density improvement. When user says "optimize this prompt", "make concise", "reduce verbosity", or before invoking skill-generator.
```

_Added both layers: contextual "when" AND trigger phrases_

#### Test 7: Multi-Dimensional (All Three)

**Input:**

```markdown
I really need you to create a comprehensive, production-ready system that will help me process my data files efficiently. You should follow these steps very carefully:

1. INPUT_PROCESSING: Read the data file → raw_data

   - Use your file reading capability
   - Parse the content carefully
   - Extract all relevant fields
   - DO NOT skip any records

2. VALIDATION: Check data quality → validated_data

   - Run validation rules
   - Flag any errors
   - Create error report
   - DO NOT proceed if critical errors found

3. TRANSFORMATION: Apply business rules → transformed_data

   - Use transformation logic
   - Handle edge cases
   - Maintain data integrity

4. OUTPUT_GENERATION: Write results → output_file
   - Format according to spec
   - Save to designated location

EXECUTION RULES:

- Follow all steps in exact order
- Do not skip any validation
- Ensure data integrity at all times
- Stop only after output file written
- DO NOT STOP after step 2 validation even if you think you're done
```

**Expected**:

- Dimension 1: Bloated (comprehensive, carefully, all, any, etc.)
- Dimension 2: Over-structured (score ~2, but has formal workflow)
- Dimension 3: Over-technical (CAPS + → + sub-bullets + warnings)
- Strategies: Technical → Natural + Constraint-Based
- Complexity score: 2 (4 steps, but linear)

**Output:**

```markdown
Process the data file and write results. MAX 4 steps:

Read the file and validate data quality. If critical errors found, stop with error report.

Transform data according to business rules. Write formatted results to output file.

The output file write completes this task.
```

**Dimensions addressed:**

- D1: Removed bloat (60% reduction)
- D2: Simplified structure (natural with light organization)
- D3: Removed ceremony (no CAPS/→/variables/warnings)

### Success Criteria

All tests must:

1. Correctly identify which dimensions need optimization
2. Select appropriate strategies (1-3, complementary)
3. Match structure to complexity score
4. Use natural notation unless technical serves precision purpose
5. Preserve intent and requirements
6. Pass cognitive load test (optimized is clearer)
7. Pass regression test (won't break execution)

---

## Part 11: Summary Principles

### The Optimization Philosophy (Revised)

**Good optimization:**

- **Reduces cognitive load** (easier to understand)
- **Preserves intent fully** (all requirements intact)
- **Matches complexity appropriately** (right structure level)
- **Uses clear notation** (natural unless technical serves precision)
- **Results in better execution** (more reliable, less ambiguous)

**Good optimization does NOT:**

- Optimize for optimization's sake
- Apply structure where natural language works better
- Use technical notation without clear purpose
- Remove necessary procedural detail
- Destroy functional trigger patterns
- Introduce new problems while fixing old ones

### Core Safety Rules

1. **Check if optimization needed** (already optimal? appropriate for complexity? notation serves purpose?)
2. **Analyze three dimensions** (verbosity, structure, notation)
3. **Match structure to complexity** (score determines appropriate level)
4. **Use natural notation by default** (technical only if serves precision purpose)
5. **Preserve callable entity triggers** (both context AND literal phrases)
6. **Use 1-3 complementary strategies** (not all available strategies)
7. **Target appropriate reduction** (40-50% agents/workflows, 60%+ docs)
8. **Test cognitive load** (is optimized version clearer?)

### The Cognitive Load Test (Central Principle)

**For every optimization, ask**: Does this reduce or increase cognitive load?

**Reduce cognitive load by:**

- Removing unnecessary words (bloat)
- Matching structure to complexity (not too much, not too little)
- Simplifying notation (natural unless technical serves precision)
- Making completion criteria clear
- Eliminating defensive warnings

**Increase cognitive load by:**

- Over-technical notation (CAPS + → + variables when unnecessary)
- Structure mismatch (formal workflow for trivial task, or vague prose for complex task)
- Removing necessary detail (vague instructions for agents)
- Destroying trigger patterns (hurts model-invocation)
- Adding too many strategies (conflicting directions)

### Decision Framework (Complete)

```
FOR EACH optimization request:

1. SAFETY CHECK
   - Already optimal? → NO optimization
   - Callable entity? → Preserve triggers (minimal optimization)
   - Agent at right detail? → NO optimization
   - Technical notation serves purpose? → Preserve notation
   - User requests preservation? → NO optimization

2. DIMENSIONAL ANALYSIS
   - Dimension 1 (Verbosity): Bloated? → Constrain and exclude
   - Dimension 2 (Structure): Mismatch? → Reframe to match score
   - Dimension 3 (Notation): Over-technical? → Simplify to natural

3. COMPLEXITY SCORING
   - Calculate score (determines appropriate structure level)
   - Match structure to score (natural → organized → formal)

4. STRATEGY SELECTION
   - Choose 1-3 complementary strategies
   - Address identified dimensional problems
   - No redundant or conflicting strategies

5. OPTIMIZATION
   - Apply selected strategies
   - Target appropriate reduction level
   - Preserve intent and requirements
   - Simplify notation by default

6. SAFETY VERIFICATION
   - Cognitive load test: Is it clearer?
   - Intent test: Requirements preserved?
   - Complexity match: Structure appropriate?
   - Notation appropriate: Natural unless precision needed?
   - Execution test: Would LLM succeed?
   - If any FAIL: Revise or recommend consult only

7. DELIVER
   - Return optimized version with rationale
   - Or recommend no optimization needed
```

### When in Doubt

**Conservative approach**: Make smaller changes. Incremental optimization is safer than aggressive transformation.

**Trust test**: If you wouldn't want to follow the optimized version yourself, don't recommend it.

**Harm prevention**: Better to leave a prompt "good enough" than to over-optimize it into something worse.

**Cognitive load wins**: When multiple approaches possible, choose the one with lowest cognitive load while preserving intent.

---

## Implementation Checklist

- [ ] Read and understand all 11 parts of this spec
- [ ] Update SKILL.md Step 2 (add dimensional analysis)
- [ ] Update SKILL.md Step 3 (add dimension-based strategy selection)
- [ ] Update SKILL.md Step 4 (add notation simplification, cognitive load test)
- [ ] Save this document as OPTIMIZATION-SAFETY-GUIDE.md in references/
- [ ] Update STRATEGIES.md (add safety note + Strategy #15: Technical → Natural)
- [ ] Update ANTI-PATTERNS.md (add Pattern 8 and Pattern 9)
- [ ] Update ADVANCED-ANTI-PATTERNS.md (add dimensional analysis note)
- [ ] Create comprehensive test suite (7 test cases minimum)
- [ ] Run test suite and verify all pass
- [ ] Verify integration with workflow-optimization-spec.md
- [ ] Update skill description in front matter if needed (add notation dimension)

**CRITICAL**: Test with real examples before deploying. Verify optimization reduces cognitive load without introducing new problems.

---

## Appendix: Quick Reference

### Three Dimensions at a Glance

| Dimension    | Problem          | Detection                       | Solution                     |
| ------------ | ---------------- | ------------------------------- | ---------------------------- |
| 1. Verbosity | Bloated          | Adjectives, filler, >2x length  | Constrain, exclude, template |
| 2. Structure | Wrong complexity | Over/under structured           | Match to complexity score    |
| 3. Notation  | Over-technical   | CAPS + → + variables + warnings | Organized natural language   |

### Complexity Score Quick Guide

| Score | Steps                   | Complexity  | Structure Level     |
| ----- | ----------------------- | ----------- | ------------------- |
| ≤ 0   | 1-2 trivial             | Very simple | Natural language    |
| 1-2   | 3-4 linear              | Low         | Light structure     |
| 3-4   | 4-6 with conditionals   | Moderate    | Organized natural   |
| ≥ 5   | 5+ with gates/branching | High        | Goal + Capabilities |

### Strategy Selection Shortcuts

- **Bloat** → Constraint-Based + Negative Prompting
- **Too much structure** → Natural Language Reframing
- **Too little structure** → Organized natural with appropriate level
- **Over-technical** → Technical → Natural Transformation (often sufficient alone)
- **Callable entity** → Callable Entity Preservation (preserve both layers)
- **Unbounded scope** → Template-Based + Constraint-Based

### Red Flags Checklist

**Stop optimization if:**

- [ ] Already optimal pattern detected
- [ ] Cognitive load would increase
- [ ] Technical notation serves clear precision purpose
- [ ] Callable entity with correct trigger structure
- [ ] Agent/workflow at appropriate detail level (40-50% reduction)
- [ ] User explicitly requests preservation

**Optimize if:**

- [ ] Bloat indicators present (Dimension 1)
- [ ] Structure mismatch detected (Dimension 2)
- [ ] Over-technical notation hurts clarity (Dimension 3)
- [ ] Cognitive load test shows improvement possible
- [ ] Intent preservation verified

---

END OF COMPREHENSIVE SPECIFICATION V2
