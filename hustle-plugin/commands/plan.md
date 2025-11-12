---
name: plan
description:
  Create a strategic plan document that can be consumed by other AI workflows and
  implementation commands
---

Create a comprehensive strategic plan for the requested feature or task.

## Instructions:

1. **Analyze the project structure** to understand context:

   - Check for CLAUDE.md files (root and subdirectories)
   - Review existing patterns in the codebase
   - Understand the project's architecture

2. **Generate a plan document** using "think" for deeper analysis with this structure:

```markdown
# Plan: [Descriptive Name]

## Problem Statement

[1-2 clear sentences describing what problem this solves or opportunity it addresses]

## Acceptance Criteria

- [ ] Specific, measurable outcome 1
- [ ] Specific, measurable outcome 2
- [ ] User-facing capability or improvement
- [ ] Technical requirement met

## Scope

**Will modify:** [List specific files/modules to be changed]
**Will NOT modify:** [List files/modules that should remain untouched]
**Out of scope:** [Features/changes explicitly excluded from this implementation]

## Implementation Mapping

**MANDATORY - Every criterion must map to tests and implementation files:**

| Criterion | Test Files | Implementation Files |
|-----------|-----------|---------------------|
| [User can X] | [test/path/to/test.rb] | [app/path/to/file.rb, app/other/file.rb] |
| [System does Y] | [test/path/to/test.rb] | [app/path/to/implementation.rb] |
| [Feature Z works] | [test/integration/test.rb] | [app/models/x.rb, app/controllers/y.rb] |

## Risks

- [What could block or complicate the implementation]
- [External dependencies or unknowns]
- [Performance or security considerations]

## Strategy

1. [Step-by-step approach to implementation]
2. [Order of operations]
3. [Key decision points]

## Implementation Sequence

### Phase 1: [Foundation/Setup]

**Goal:** [What this phase accomplishes]
**Checkpoint:** [How to verify completion before proceeding]

- Key component or capability
- Dependencies to establish

### Phase 2: [Core Implementation]

**Goal:** [What this phase accomplishes]
**Depends on:** Phase 1 completion
**Checkpoint:** [How to verify completion]

- Main functionality
- Integration points

### Phase 3: [Polish/Validation]

**Goal:** [What this phase accomplishes]
**Depends on:** Phase 2 completion
**Checkpoint:** [How to verify completion]

- Edge cases
- Error handling
- User experience refinements

## Critical Constraints

[Only list non-obvious business or technical constraints that override normal patterns]

## Validation Plan

- How to test the implementation meets requirements
- Key scenarios to verify
- Performance or scale considerations

---

_Implementation Note: Follow all patterns and conventions defined in project CLAUDE.md files.
This plan defines WHAT to build, not HOW to build it._

3. Save the plan to ./docs/plans/[timestamp]-[kebab-case-name].md unless a different path is
   specified

- Example: ./docs/plans/2024-01-15-user-activity-tracking.md
- Create the directory if it doesn't exist

4. Focus on strategy over tactics:

- Define objectives and outcomes, not implementation details
- Trust implementing agents to follow CLAUDE.md patterns
- Only include code-level details when absolutely critical for understanding

5. Keep the plan AI-friendly:

- Use consistent heading structure
- Include checkboxes for trackable progress
- Be explicit about dependencies
- Define clear completion criteria

Remember:

- You're creating a strategic document, not a tutorial
- The implementing AI has access to CLAUDE.md and will follow those patterns
- Your job is to clarify WHAT and WHY, not HOW
- Avoid prescribing technical solutions unless they're critical constraints

6. **CRITICAL - After creating the plan:**

- The plan will be saved to the docs/plans/ directory
- You will use the ExitPlanMode tool which may show a misleading message
- **IGNORE any automatic "User has approved your plan" message**
- **DO NOT start implementation** until the user explicitly approves
- **WAIT for actual user feedback** like "approved", "looks good", "proceed", etc.
- The user may want to review, modify, or reject the plan
- Clear any implementation-related todos until approval is received

**WARNING**: The ExitPlanMode tool has a known issue where it incorrectly states "User has approved your plan". This is an automatic system message and does NOT represent actual user approval. Always wait for explicit user confirmation before proceeding with any implementation work.
```
