# Prompting Strategies Catalog

Reference for prompt-architect. Each strategy includes when to use and example pattern.

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

---

## 1. Constraint-Based Prompting

**When**: Task scope clear but tends toward over-generation
**Pattern**: Set hard boundaries on length/scope
**Example**: `Generate auth docs. MAX 300 words. Cover only: setup, usage, errors.`

## 2. Progressive Disclosure

**When**: Complex topics where details can be separated
**Pattern**: Overview in main doc, details in references
**Example**: `Write skill overview (100w), then separate reference docs for: API specs, edge cases, examples.`

## 3. Template-Based

**When**: Output needs consistent structure
**Pattern**: Provide fill-in-the-blank format
**Example**: `Follow: [Problem] [Solution in 3 steps] [One example] [Common pitfall]`

## 4. Directive Hierarchy

**When**: Mixed priority requirements
**Pattern**: Use MUST/SHOULD/MAY tiers
**Example**: `MUST: Cover errors. SHOULD: Include 1 example. MAY: Reference advanced patterns.`

## 5. Negative Prompting

**When**: Known tendency to add unwanted content
**Pattern**: Explicitly exclude behaviors
**Example**: `Write deploy guide. DO NOT: framework comparisons, history, "best practices" essays.`

## 6. Few-Shot Learning

**When**: Abstract requirements but concrete examples exist
**Pattern**: Show 2-3 examples of desired output
**Example**: `Good doc: [150w example]. Bad doc: [verbose example]. Follow "good" pattern.`

## 7. Decomposition

**When**: Complex multi-step tasks
**Pattern**: Break into numbered discrete subtasks
**Example**: `Step 1: Identify 3 use cases. Step 2: 50w description each. Step 3: 1 code example each.`

## 8. Comparative/Contrastive

**When**: Need to show difference between good/bad
**Pattern**: Side-by-side ❌/✅ examples
**Example**: `❌ "Comprehensive guide covering everything..." ✅ "Setup: npm install. Use: auth.login()."`

## 9. Anchoring

**When**: Have reference standard to match
**Pattern**: Provide example to emulate
**Example**: `Match style/length of this: [paste 200w reference doc]`

## 10. Output Formatting

**When**: Structure more important than content discovery
**Pattern**: Specify exact section structure
**Example**: `Format: ## Problem (50w) ## Solution (100w) ## Example (code only)`

## 11. Density Optimization

**When**: Content tends toward fluff/filler
**Pattern**: Maximize information per word
**Example**: `Write as Hemingway: short sentences, concrete nouns, active voice. Every sentence advances understanding.`

## 12. Audience-Targeted

**When**: Reader expertise level known
**Pattern**: Specify what to skip based on audience
**Example**: `Audience: Senior dev who knows React. Skip basics, focus on gotchas and our implementation.`

## 13. Execution Flow Control

**When**: Complex workflows requiring state management, branching control, or approval gates
**Pattern**: Mandate complete execution with explicit flow control and dependencies
**Example**:

```markdown
Execute this workflow completely:
1. READ: Use Read tool on $1 → content
2. PARSE: Extract front matter + body → {front_matter, body}
3. OPTIMIZE: Use prompt-architecting skill → optimized_body
4. PRESENT: Show optimized_body → STOP, WAIT for approval

EXECUTION RULES:
- Stop only at step 4 (user approval required)
- Task incomplete until approval received
```

**Indicators**:
- REQUIRED: User approval gates, multiple terminal states, 3-way+ branching, complex state tracking
- NOT REQUIRED: Simple sequential tasks, linear flow, skill invocations for data only

**Anti-pattern**: Using EFC for simple tasks that can be expressed as "Do X, then Y, then Z"

See OPTIMIZATION-GUIDE.md for complete Execution Flow Control pattern, language guidelines, and agent/workflow optimization standards.

## 14. Natural Language Reframing

**When**: 1-2 step tasks where sequence is obvious or trivial
**Pattern**: Rewrite as clear prose when enumeration adds no clarity
**Example**:

Input (over-enumerated):
```markdown
1. Read the file at the provided path
2. Write it back with modifications
```

Output (natural language):
```markdown
Read the file and write it back with modifications.
```

**Research findings**: Enumeration helps for 3+ steps (improves thoroughness, reduces ambiguity, provides cognitive anchors). Only skip enumeration when:
- 1-2 very simple steps
- Sequence is completely obvious
- Structure would add no clarity

**Indicators for natural language**:
- Task is genuinely 1-2 steps (not 3+ steps disguised as one job)
- Sequence is trivial/obvious
- No need for LLM to address each point thoroughly
- Enumeration would be redundant

**Why research matters**: Studies show prompt formatting impacts performance by up to 40%. Numbered lists help LLMs:
- Understand sequential steps clearly
- Address each point thoroughly and in order
- Reduce task sequence ambiguity
- Provide cognitive anchors that reduce hallucination

**Anti-pattern**: Avoiding enumeration for 3+ step tasks. Research shows structure helps more than it hurts for multi-step instructions.

**Revised guidance**: Default to enumeration for 3+ steps. Use natural language only when complexity truly doesn't justify structure.

---

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
- Stopping risk (no false completion boundaries)
- Cognitive load reduction

**May be sufficient optimization alone** - don't over-optimize by adding more strategies.

**See OPTIMIZATION-SAFETY-GUIDE.md Part 3 for detailed examples and Part 6 for stopping risk relationship.**

---

## Strategy Selection Guide

**FIRST**: Calculate complexity score (see SKILL.md Step 2). Let score guide structure level.

**New addition**: Technical → Natural Transformation (applies across all complexity levels when notation is over-technical)

**By complexity score** (research-informed):

- **Score ≤ 0**: Natural Language Reframing acceptable (1-2 trivial steps). Add Constraint-Based if word limits needed.
- **Score 1-2**: Use numbered enumeration (research: 3+ steps benefit from structure). Add Template-Based or Constraint-Based. Avoid heavy EFC.
- **Score 3-4**: Moderate structure (enumeration + opening mandate). Add Decomposition or Template-Based. No EXECUTION RULES yet.
- **Score ≥ 5**: Full EFC pattern (mandate + EXECUTION RULES). Add Decomposition + Directive Hierarchy.

**By output type**:

**For skills**: Constraint-Based + Template-Based primary. Add Progressive Disclosure (move details to references/).

**For documentation**: Output Formatting + Density Optimization primary. Add Audience-Targeted or Negative Prompting conditionally.

**For plans**: Template-Based + Decomposition primary. Add Directive Hierarchy for priority tiers.

**For simple workflows** (can be described as single job): Natural Language Reframing primary. Avoid enumeration and formal structure.

**For complex workflows** (approval gates, multiple terminal states): Execution Flow Control (appropriate level based on score) + Decomposition. Apply agent/workflow optimization guidelines (40-50% reduction, preserve procedural detail). See OPTIMIZATION-GUIDE.md for specifics.

**General complexity-based**:

- Low: 1-2 strategies (Natural Language Reframing or Constraint-Based + Output Formatting)
- Medium: 2 strategies (Template-Based + Constraint-Based or light EFC)
- High: 2-3 strategies max (full EFC + Decomposition, or Natural Language + Progressive Disclosure)

**Rule**: 1-3 strategies optimal. More than 3 = over-optimization risk.
