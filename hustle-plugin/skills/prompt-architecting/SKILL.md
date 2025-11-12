---
name: prompt-architecting
description:
  "Optimizes or analyzes prompts using proven strategies. Use when user
  provides a prompt for optimization/analysis, or before you generate any prompt content
  yourself (commands, skills, agents, docs, instructions). Two modes: OPTIMIZE (returns
  optimized prompt), CONSULT (analysis only). Trigger phrases: 'optimize prompt',
  'analyze this prompt', 'make concise'."
allowed-tools:
  - Read
---

# prompt-architecting

Optimizes unstructured prompts into constrained, strategy-driven instructions that prevent over-generation and verbosity.

## When to Use

Trigger phrases: "optimize this prompt", "make instructions concise", "architect this prompt", "what's the best way to prompt for X"

## Your Task

When this skill is used, you are acting as a **prompt architect**. Your job:

Transform an unstructured task request into a constrained, strategy-driven prompt that prevents over-generation and verbosity.

**You will receive:**

- Task description (what needs to be generated)
- Content (the actual content to analyze/optimize)
- Output type (skill / docs / plan / instructions / other)
- Complexity level (low / medium / high - or infer it)
- Constraints (max length, format, audience, exclusions - or none)
- Architecture reference (optional file path to architecture specification)
- Mode (optional: "consult" or "optimize", defaults to "optimize")

**You will output (mode=optimize):**

- Analysis of complexity and bloat risks
- 2-3 selected strategies with rationale
- Optimized, constrained prompt (ready to use)
- Summary of constraints applied

**You will output (mode=consult):**

- Analysis of complexity and bloat risks
- Recommended strategies with rationale
- Optimization potential assessment
- Recommendations (no optimized prompt)

## Analysis Mode

ULTRATHINK: Prioritize accuracy over speed. Take time to:

- **Semantic before syntactic**: What is this actually trying to accomplish?
- Identify content type (agent/workflow vs docs/skills)
- Distinguish bloat from necessary procedural detail
- **Research-informed structure decisions**: Formatting impacts performance significantly (40%+ variance in template studies); practical experience suggests enumeration helps for 3+ sequential steps
- Select appropriate reduction target (40-50% vs 60%+)
- Choose optimal strategy combination (1-3 max)

**Core principle (research-validated)**: Prompt formatting significantly impacts LLM performance (up to 40% variance, sometimes 300%+). Structure provides cognitive anchors that reduce hallucination and improve thoroughness. Default to enumeration for 3+ steps; use natural language only when structure adds no clarity.

**Key research findings**:

- Numbered lists help LLMs understand sequential steps and address each point thoroughly
- Structure reduces ambiguity about task sequence
- LLMs mirror the formatting structure you provide
- Enumeration works not because of the numbers, but because of pattern consistency and correct ordering

Careful analysis prevents over-optimization and vague instructions.

## Process

Follow these steps:

1. Read reference materials (strategies, anti-patterns, examples from references/)
2. Analyze the task (complexity, bloat risks, structure needs, target length)
3. Select 1-3 strategies based on complexity score and bloat risks
4. Generate output (optimized prompt or consultation analysis depending on mode)

### Step 1: Read Reference Materials

ALWAYS start by reading these files (progressive disclosure loads them on-demand):

- `~/.claude/skills/prompt-architecting/references/STRATEGIES.md` (15 prompting strategies catalog)
- `~/.claude/skills/prompt-architecting/references/ANTI-PATTERNS.md` (basic bloat patterns)
- `~/.claude/skills/prompt-architecting/references/ADVANCED-ANTI-PATTERNS.md` (workflow/agent patterns - read if optimizing workflows)
- `~/.claude/skills/prompt-architecting/references/EXAMPLES.md` (basic case studies)
- `~/.claude/skills/prompt-architecting/references/ADVANCED-EXAMPLES.md` (workflow/agent case studies - read if optimizing workflows)

IF architecture_reference provided:

- Read the architecture file at the provided path
- Understand required sections, patterns, and structural requirements
- This will guide refactoring in Step 4

### Step 2: Analyze the Task

Evaluate and explicitly STATE:

**FIRST: Safety checks (prevent harmful optimization)**

Check if content should NOT be optimized:

- Already optimal pattern? (deliverable-first + natural/appropriate structure + right complexity + appropriate notation)
- Callable entity description at correct structure? (context + triggers present)
- Agent/workflow at 40-50% of bloated version with specificity intact?
- Technical notation serving clear purpose? (API specs, standard conventions, precision needed)
- User requests preservation?

**If any YES**: STATE "Optimization not recommended: [reason]" and use mode=consult to provide analysis only.

- **Semantic analysis** (SECOND - most important):

  - What is the core job this is trying to accomplish?
  - Can it be expressed as a single coherent task in natural language?
  - Test: Describe in one sentence using "then/if/when" connectors
  - Example: "Read file, optimize with skill (preserving header if present), write back"
  - **If YES**: Consider natural language reframing instead of formal structure
  - **If NO**: Task may need structured breakdown

- **Complexity scoring** (determines structure level):
  Calculate score based on these factors:

  - 1-2 steps with obvious sequence? → **-1 point**
  - 3-4 steps where sequence matters? → **+1 point**
  - 5+ sequential steps? → **+2 points**
  - Has user approval gates (WAIT, AskUserQuestion)? → **+3 points**
  - Has 2+ terminal states (different end conditions)? → **+2 points**
  - Has 3-way+ conditional branching? → **+2 points**
  - Simple if/else conditionals only? → **+0 points**
  - Skill invocation just for data gathering? → **+0 points**
  - Skill invocation affects control flow decisions? → **+1 point**

  **Score interpretation** (research-aligned):

  - Score ≤ 0: Natural language framing acceptable (1-2 simple steps)
  - Score 1-2: Numbered enumeration helps (research: improves thoroughness, reduces ambiguity)
  - Score 3-4: Moderate structure (enumeration + opening mandate, no EXECUTION RULES)
  - Score ≥ 5: Full formal structure (complete EFC pattern with EXECUTION RULES)

- **Bloat risks**: What specifically could cause over-generation? (edge cases, theoretical coverage, defensive documentation, etc.)

- **Workflow structure assessment**:

  - Count sequential steps in input (look for "Step 1", "Step 2", numbered workflow)
  - Check for skill/agent invocations (are they just data gathering or control flow?)
  - Check for user approval gates (AskUserQuestion, explicit WAIT/STOP)
  - Check for multiple terminal states (different ways the task can end)
  - Check if input already has Execution Flow Control (opening mandate, data flow notation, EXECUTION RULES)
  - **Structure determination** based on complexity score:
    - "Complexity score: [X]. Recommendation: [Natural language / Light structure / Moderate structure / Full EFC]"

- **Target length**: Calculate optimal word/line count based on complexity and output type

- **Architecture compliance** (if architecture_reference provided):
  - Compare input structure to architecture requirements
  - Identify missing required sections
  - Identify structural misalignments
  - State: "Architecture: [compliant/partial/non-compliant]. Missing: [list]. Misaligned: [list]."

**Dimensional analysis (if optimization appropriate)**

Evaluate each dimension:

**Dimension 1 (Verbosity):**

- Bloat indicators present? (adjective-heavy, scope inflation, vague quality statements, meta-discussion, filler, repetition)
- Current word count vs. ideal for task? (>2x ideal = bloat)
- State: "Verbosity: [bloated/concise/appropriate]. Reduction needed: [yes/no]"

**Dimension 2 (Structure):**

- Complexity score already calculated above
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

**Callable entity check** (if description field):

- Contextual "when" conditions: present/vague/missing
- Trigger phrases (quoted literals): present/weak/missing
- Delegation signals if subagent: present/missing/N/A
- Integration points: present/missing/N/A
- Structure: complete/context-only/triggers-only/missing

**Workflow pattern detection** (if skill/agent invocations):

- High-risk stopping patterns present? (CAPS + → + variables + remote rules + warnings)
- Classification: high-risk / optimal / standard
- Stopping risk: yes/no
- Note: High-risk patterns are Dimension 3 problem (over-technical notation)

**Complexity guidelines:**

| Level  | Target Length | Notes                                     |
| ------ | ------------- | ----------------------------------------- |
| Low    | 100-200w      | Straightforward tasks                     |
| Medium | 200-400w      | Moderate scope                            |
| High   | 400-600w      | Use progressive disclosure to references/ |

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

### Step 4: Generate Output

Based on mode:

**IF mode=consult:**

- DO NOT generate optimized prompt
- Output analysis, recommended strategies, and optimization potential
- If architecture provided, include architecture compliance assessment
- Use consult output format (see Output Format section below)

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
  - Example: See "appropriately optimized" examples in OPTIMIZATION-SAFETY-GUIDE.md

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
- Add missing required sections (Purpose, Workflow, Output, etc.)
- Preserve required patterns (asset references, error formats, etc.)
- Optimize content WITHIN architectural structure (don't remove structure)

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

## Output Format

You MUST structure your response based on mode:

**For mode=optimize:**

```markdown
## Analysis

- Task complexity: {low|medium|high}
- Primary bloat risks: {2-3 specific risks identified}
- Architecture compliance: {if architecture_reference provided}
- Target length: {calculated word/line count based on complexity}

## Selected Strategies

- **{Strategy Name}**: {1 sentence why chosen for this specific task}
- **{Strategy Name}**: {1 sentence why chosen}
- **{Strategy Name}** (if needed): {1 sentence why chosen}

## Optimized Prompt

{The actual constrained prompt - this gets used directly by the executor}

{Prompt should be 3-10 sentences with:

- Clear scope boundaries
- Specific word/line limits
- Explicit structure (sections, format)
- DO NOT clauses if bloat risks identified
- Reference to examples if anchoring strategy used
- Architecture alignment directives (if architecture provided)}

## Constraints Applied

- Word/line limits: {specific counts}
- Structure: {template or format specified}
- Exclusions: {what NOT to include}
- Architecture: {required sections/patterns preserved if applicable}
- Other: {any additional constraints}
```

**For mode=consult:**

```markdown
## Analysis

- Task complexity: {low|medium|high}
- Primary bloat risks: {2-3 specific risks identified}
- Architecture compliance: {if architecture_reference provided}
- Target length: {calculated word/line count based on complexity}

## Recommended Strategies

- **{Strategy Name}**: {1 sentence why recommended for this specific task}
- **{Strategy Name}**: {1 sentence why recommended}
- **{Strategy Name}** (if needed): {1 sentence why recommended}

## Optimization Potential

- Content reduction: {estimated percentage - e.g., "40-50% reduction possible"}
- Structural changes needed: {list if architecture provided - e.g., "Add Output Format section, refactor steps"}
- Bloat removal: {specific areas - e.g., "Remove verbose library comparisons, consolidate examples"}

## Recommendations

{2-4 sentence summary of what should be done to optimize this content}
```

## Errors

**"Missing required parameter"**: Task description or content not provided. Cannot analyze without content to optimize. Provide: task description, content, output type.

**"Invalid architecture_reference path"**: File path doesn't exist or isn't readable. Verify path exists: ~/.claude/skills/skill-generator/references/SKILL-ARCHITECTURE.md

**"Unsupported output type"**: Output type not recognized. Supported: skill, docs, plan, instructions, command, agent.

**"Mode parameter invalid"**: Mode must be "optimize" or "consult". Defaults to "optimize" if not specified.
