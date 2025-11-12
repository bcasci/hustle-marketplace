# Real-World Optimization Examples

Case studies showing prompt-architecting in action.

## Example 1: Skill Generation

### Original Request

```
User: "Create a skill for processing PDFs"
```

### Without Optimization

Claude generates:

- 1,200-line SKILL.md with 15 subsections
- Complete PDF specification history
- 8 different extraction libraries compared
- 20 edge cases documented inline
- Security considerations essay
- Performance tuning guide
- Complete API reference

### With prompt-architecting

**Subagent analysis:**

- Task: Skill creation
- Complexity: Medium (PDF parsing is known domain)
- Risk: Over-documentation of libraries, edge cases
- Optimal strategies: Constraint-Based, Template-Based, Progressive Disclosure

**Optimized prompt:**

```
Create PDF processing skill. SKILL.md MAX 300 words:
- When to use (50w)
- Core workflow: upload → extract text/images → output (100w)
- One example showing pypdf2 usage (code only, 100w)
- Move to references/: library comparison (pypdf2 vs pdfplumber), OCR for scanned PDFs, encoding issues

Match this style: {paste concise skill example from building-skills}
```

**Result:** 280-word SKILL.md, 2 reference files, actionable and maintainable

---

## Example 2: Documentation Generation

### Original Request

```
User: "Document the API endpoints in src/api/"
```

### Without Optimization

Claude writes:

- Comprehensive REST API guide
- HTTP protocol primer
- Authentication deep-dive
- Rate limiting theory
- Pagination best practices
- Error handling philosophy
- 40 pages of markdown

### With prompt-architecting

**Subagent analysis:**

- Task: API documentation
- Complexity: Low (structured data)
- Risk: Theory instead of reference
- Optimal strategies: Output Formatting, Template-Based, Negative Prompting

**Optimized prompt:**

```
Document API endpoints. Format per endpoint:
## [METHOD] /path
Purpose: {1 sentence}
Auth: {required|optional|none}
Params: {table: name, type, required, description}
Response: {JSON schema only}
Errors: {codes list}
Example: {curl + response}

DO NOT: Include HTTP theory, auth implementation details, or pagination strategy essays.
Target: API reference, not guide.
```

**Result:** Clean reference docs, 8 endpoints in 4 pages, instantly usable

---

## Example 3: Plan Creation

### Original Request

```
User: "Plan the implementation of user notification system"
```

### Without Optimization

Claude creates:

- 15-page plan with every possible notification type
- Complete microservices architecture
- Email, SMS, push, in-app, webhook notifications
- Queue theory and message broker comparison
- Scaling strategy for 1M users
- 30 implementation tasks spanning 6 months

### With prompt-architecting

**Subagent analysis:**

- Task: Implementation plan
- Complexity: High (but scope unclear)
- Risk: Over-engineering, scope creep
- Optimal strategies: Decomposition, Directive Hierarchy, Constraint-Based

**Optimized prompt:**

```
Create notification system plan. Scope: Email + in-app only (MVP).

MUST cover:
- Data model (users, notifications, preferences)
- Notification creation flow
- Delivery mechanism (async job)
- User preferences UI

SHOULD cover:
- Read/unread state
- Basic templates

OUT OF SCOPE: SMS, push, webhooks, scaling >10K users

Structure: [Problem] [Phase 1 tasks] [Phase 2 tasks] [Success criteria]
Target: 2-week implementation for 2 devs
```

**Result:** Focused 4-page plan, 12 actionable tasks, clear scope, deliverable

---

## Example 4: Code Review Request

### Original Request

```
User: "Review this code and tell me what you think"
```

### Without Optimization

Claude provides:

- Line-by-line analysis
- Code style commentary
- Design pattern suggestions
- Performance speculation
- Security theoretical concerns
- Refactoring proposal (3 alternatives)
- 800 lines of feedback

### With prompt-architecting

**Subagent analysis:**

- Task: Code review (but criteria unknown)
- Complexity: Medium
- Risk: Unfocused feedback overload
- Optimal strategies: Constraint-Based, Audience-Targeted, Decomposition

**Optimized prompt:**

```
Review code for: (1) Bugs/errors, (2) Security issues, (3) Performance bottlenecks.

Format:
## Issues Found
- [SEVERITY] Location: Description + fix suggestion

## Summary
- {Count by severity}
- {Top priority item}

DO NOT: Comment on style, suggest refactorings, or discuss alternative patterns unless directly related to bugs/security/performance.

Audience: Code works, need to ship, focused review only.
```

**Result:** 15-line review, 2 bugs found, 1 security fix, actionable

---

**For advanced workflow and agent optimization examples, see ADVANCED-EXAMPLES.md**

---

## Lessons Learned

**Unspecified scope = maximal scope** (Examples 1-3): Without constraints, Claude assumes comprehensive coverage. Fix: Set MAX length and explicit boundaries.

**Complexity triggers research mode** (Examples 1, 2): Unfamiliar topics trigger defensive over-documentation. Fix: Progressive Disclosure - overview now, details in references.

**Ambiguous success = everything** (Example 3): "Help me understand" lacks definition of done. Fix: Define success concretely ("New dev deploys in <10min").

**Implicit = inclusion** (Examples 2, 4): Unexcluded edge cases get included. Fix: Negative Prompting to exclude known bloat.

**Workflow patterns** (see ADVANCED-EXAMPLES.md): Numbered steps don't mandate completion after async operations. Fix: Execution Flow Control.

**Meta-lesson**: Every optimization uses 2-3 strategies, never just one. Pair Constraint-Based with structure (Template/Format) or exclusion (Negative). For workflows with dependencies, Execution Flow Control is mandatory.
