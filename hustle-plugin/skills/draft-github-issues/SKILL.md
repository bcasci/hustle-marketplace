---
name: draft-github-issues
description: |
  Draft GitHub issues as YAML files from plans or requirements. Use this skill when:
  - User says "draft issues" or "create issue draft", or suggests refinements to the draft issues
  - Converting plans/requirements into GitHub issue format
  - User provides a plan file path (docs/plans/*.md)
  - Need to structure multiple related issues with parent-child relationships

  Generates YAML files in tmp/issues/ for review before publishing to GitHub.
allowed-tools: "Read, Write, Edit, Task(analyst)"
---

# Draft GitHub Issues

Base directory for this skill: {baseDir}

## Purpose

Convert plans, requirements, or verbal descriptions into structured YAML files containing GitHub issue definitions. The YAML can be reviewed, edited, and published using the `publish-github-issues` skill.

## Prerequisites

- Git repository with GitHub remote (to detect repo name)
- Optional: Plan file (docs/plans/\*.md) or verbal requirements

## Workflow Overview

1. **Draft** - Generate YAML from plan/requirements
2. **Refine** (optional) - Analyze and improve YAML

Publishing happens separately via `publish-github-issues` skill.

---

## Step 1: Draft Issues from Requirements

**Input:** Plan file path, text description, or verbal requirement

**Actions:**

1. Parse requirement into logical issues (pattern: data → logic → UI)
2. Determine issue set name from requirement (ask user only if ambiguous)
3. Detect repository from git remote (ask user if not found: format owner/repo)
4. Generate outcome-focused titles and acceptance criteria for each issue
5. **Evaluate each issue for technical context:**
   - Use analyst subagent if issue mentions or implies:
     - Multiple systems/models (integration)
     - Performance/scale requirements (>100 records, <200ms, etc.)
     - Security keywords (auth, permissions, tenant, isolation)
     - Background jobs, async processing, queues
     - New functionality in unfamiliar domain
   - Skip analyst subagent for:
     - Standard CRUD (add field, basic form)
     - UI-only changes (text, styling, layout)
     - Copying existing pattern explicitly
6. **When invoking analyst:**
   - Pass: issue title, acceptance criteria, and requirement context
   - Request: "Provide technical breadcrumbs: primary domain, similar patterns, integration points, gotchas (3-5 bullets)"
   - Insert Technical Context section in issue body after acceptance criteria
7. Save YAML to `./tmp/issues/{name}-{timestamp}.yml`
8. Report: which issues were enriched with analyst context

**Technical Context Format:**

```yaml
### Technical Context
- Primary domain: [models/controllers]
- Similar pattern: [existing feature]
- Integration points: [connections]
- Consider: [gotcha/constraint]
```

**Output:**

```text
Draft saved: ./tmp/issues/user-search-20251102-143022.yml

Enriched 3 of 4 issues with technical context.

Next: Review file, then refine or publish using publish-github-issues skill.
```

**Errors:**

- Missing tmp/: Create it
- File collision: Add timestamp suffix
- No git remote: Ask for repo (owner/repo)

---

## Step 2: Refine Draft (Optional)

**Input:** Path to draft YAML file

**Actions:**

1. Read and parse YAML
2. Analyze each issue:
   - Titles outcome-focused (WHAT not HOW)?
   - Acceptance criteria specific and testable?
   - Parent-child relationships logical?
   - Labels appropriate?
   - Technical context present where valuable?
3. Apply improvements directly to file
4. Report changes made

**Output:**

```text
Refined tmp/issues/user-search-20251102.yml

Changes:
- Issue #2: Changed title from "Implement SearchService" to "Enable search functionality"
- Issue #3: Added specific acceptance criteria for error handling
- Issue #4: Added technical context (was missing analyst breadcrumbs)

File updated.

Next: Review changes, then publish using publish-github-issues skill.
```

**Errors:**

- File not found: Report and exit
- Invalid YAML: Report parse error with line number
- Empty file: Report and exit

---

## YAML Structure and Issue Format

See `{baseDir}/references/YAML-FORMAT.md` for complete specification and examples of:

- YAML structure (repository, defaults, issues)
- Issue formatting (title, body, acceptance criteria)
- Parent-child relationships
- Optional fields (milestones, labels, projects)

---

## Examples

See `{baseDir}/references/YAML-FORMAT.md` for complete YAML examples.

### Example 1: Draft from Plan File

**User:** "Draft issues from docs/plans/paddle-integration.md"

**Output:**

```
Reading docs/plans/paddle-integration.md...
Analyzing requirements...
Invoking analyst for technical context (3 of 3 issues)...

Draft saved: tmp/issues/paddle-integration-20251105.yml

Enriched 3 of 3 issues with technical context.

Next: Review file, then publish using publish-github-issues skill.
```

### Example 2: Refine Draft

**User:** "Refine tmp/issues/paddle-integration-20251105.yml"

**Output:**

```
Reading tmp/issues/paddle-integration-20251105.yml...
Analyzing structure and content...

Refined tmp/issues/paddle-integration-20251105.yml

Changes:
- Issue #2: Changed title to be more outcome-focused
- Issue #2: Added specific acceptance criteria for webhook events
- Issue #3: Added technical context about data migration risks

File updated.

Next: Review changes, then publish using publish-github-issues skill.
```

### Example 3: Draft from Verbal Requirements

**User:** "Draft issues for adding user authentication with OAuth providers"

**Output:**

```
Detecting repository: myorg/myapp
Generating issues...
Invoking analyst for security context...

Draft saved: tmp/issues/user-auth-20251105.yml

Enriched 2 of 3 issues with technical context.

Next: Review file, then publish using publish-github-issues skill.
```

---

## Tips for Good Issues

### Titles

- ✅ "Enable search functionality"
- ❌ "Implement SearchService class"

### Acceptance Criteria

- ✅ "Users can search posts by keyword"
- ❌ "Add search method"

### Technical Context (when analyst enriched)

- Helps future implementers find relevant code
- Points to similar patterns in codebase
- Highlights gotchas and constraints
- NOT prescriptive (doesn't dictate HOW)

---

## Common Errors

**"No git remote found"**

- Run: `git remote -v` to check
- Add remote: `git remote add origin https://github.com/owner/repo.git`
- Or provide repo manually when asked

**"tmp/ directory doesn't exist"**

- Skill will create it automatically
- Located at project root: `./tmp/issues/`

**"Ambiguous issue set name"**

- Skill will ask for clarification
- Provide short name (e.g., "user-search", "auth-system")

---

## Next Steps After Drafting

1. **Review YAML file** - Check titles, criteria, structure
2. **Edit manually** (optional) - Modify YAML directly if needed
3. **Refine** (optional) - Use this skill's refine step
4. **Publish** - Use `publish-github-issues` skill to create on GitHub

---

## Resources

- YAML format specification: `{baseDir}/references/YAML-FORMAT.md`
