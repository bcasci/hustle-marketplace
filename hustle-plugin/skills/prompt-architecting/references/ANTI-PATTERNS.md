# Anti-Patterns: Verbose → Concise

Real examples of prompt bloat and their optimized versions.

## Pattern 1: Over-Elaborated Context

### ❌ Verbose
```
I need you to create comprehensive documentation that covers all aspects of
user authentication in our system. This should include detailed explanations
of how the system works, what technologies we're using, best practices for
implementation, common pitfalls to avoid, security considerations, edge cases,
error handling strategies, and example code showing different use cases. Make
sure it's thorough and covers everything a developer might need to know.
```

### ✅ Optimized
```
Write auth docs. Structure: [Setup - 100w] [Usage - 150w] [Error handling - 100w]
[One example - code only]. MAX 400 words total. Audience: Mid-level dev familiar
with JWT. DO NOT: Include security theory, framework comparisons, or "best practices"
sections.
```

**Strategies applied**: Constraint-Based, Output Formatting, Negative Prompting

---

## Pattern 2: Defensive Over-Coverage

### ❌ Verbose
```
Create a skill for processing CSV files. It should handle reading CSV files,
parsing them, validating the data, transforming it, handling errors, dealing
with different encodings, managing large files, streaming if needed, and
outputting to various formats. Include comprehensive documentation, examples
for each use case, edge case handling, performance considerations, and detailed
setup instructions.
```

### ✅ Optimized
```
Create CSV processing skill. SKILL.md (300w max): [Problem - 50w] [Workflow:
read → parse → transform → output - 100w] [One example - code only - 100w].
Move to references/: encoding edge cases, streaming for large files, pandas vs
csv module comparison.
```

**Strategies applied**: Constraint-Based, Progressive Disclosure, Template-Based

---

## Pattern 3: Meta-Discussion Instead of Instructions

### ❌ Verbose
```
I think we should probably create some documentation for the API endpoints.
It would be good to explain what each endpoint does, what parameters they take,
what they return, and maybe some examples of how to use them. We should also
probably mention error codes and authentication requirements. Does that sound good?
```

### ✅ Optimized
```
Document REST API endpoints. Format per endpoint: [Method + Path] [Purpose - 1
sentence] [Parameters - table] [Response - JSON schema] [Auth required - yes/no]
[Error codes - list only]. One example request/response per endpoint.
```

**Strategies applied**: Output Formatting, Template-Based, Density Optimization

---

## Pattern 4: Unclear Success Criteria

### ❌ Verbose
```
Help me understand how the deployment process works in this codebase and create
some documentation about it so other developers can figure it out too.
```

### ✅ Optimized
```
Document deployment process. Target: New dev can deploy to staging in <10 min.
Structure: [Prerequisites - bullet list] [Steps - numbered, 1 sentence each]
[Verification - how to confirm success] [Rollback - 2 sentences]. MAX 300 words.
```

**Strategies applied**: Audience-Targeted, Template-Based, Constraint-Based

---

## Pattern 5: Solution Seeking Instead of Problem Stating

### ❌ Verbose
```
We need a really robust, production-grade, enterprise-level authentication
system with all the features and best practices implemented following industry
standards and security guidelines...
```

### ✅ Optimized
```
Implement auth. Requirements: JWT tokens, refresh flow, role-based access.
MUST: Secure token storage, HTTPS only. SHOULD: Remember me option. OUT OF SCOPE:
OAuth, SSO, 2FA. Match existing pattern in: src/auth/session.ts
```

**Strategies applied**: Directive Hierarchy, Negative Prompting, Anchoring

---

## Common Bloat Indicators

**Red flags in prompts:**
- "comprehensive", "robust", "enterprise-grade", "production-ready"
- "all aspects", "everything", "fully cover"
- "best practices", "industry standards"
- Multiple questions without priority
- Hypothetical edge cases ("what if...", "we might need...")

**Optimization checklist:**
1. Remove adjectives (comprehensive, robust, etc.)
2. Set word/line limits
3. Specify structure explicitly
4. Use DO NOT for known over-generation
5. Define success criteria concretely
6. Defer details to references where possible

**Decision tree:**

- Adjective-heavy? → Constraint-Based
- No structure? → Template-Based or Output Formatting
- Known bloat patterns? → Negative Prompting
- 1-2 very simple steps (sequence obvious)? → Natural language acceptable
- 3+ steps where sequence matters? → Enumeration helps (research: improves thoroughness and reduces ambiguity)
- Complex task with branching? → Execution Flow Control (appropriate level)
- Numbered steps but overly formal? → Simplify notation, keep enumeration for clarity
- Agent/workflow with repeated procedural steps? → DRY refactoring (extract shared checklist)
- Procedural detail appears as bloat? → Preserve specificity, target 40-50% reduction
- Need examples? → Few-Shot or Anchoring

---

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

**See OPTIMIZATION-SAFETY-GUIDE.md Part 4 for callable entity preservation rules.**

---

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
