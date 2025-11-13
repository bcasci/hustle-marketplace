---
name: draft-github-issues
description: Drafts GitHub issues as YAML files from plans or requirements. Use when converting plans to issue format or structuring multiple related issues with parent-child relationships. Needs git repository with remote (for repo detection) and optional plan file or verbal requirements. Trigger with phrases like 'draft issues [from file-path]', 'create issue draft', 'draft github issues for [description]'.
allowed-tools: "Read, Write, Edit, Task(analyst)"
---

Base directory for this skill: {baseDir}

## Workflow

**Draft Mode:** Generate YAML from plan/requirements → save to tmp/issues/
**Refine Mode:** Analyze and improve existing YAML draft

Publishing happens separately via `publish-github-issues` skill.

<drafting>

## Draft Issues from Requirements

**Input:** Plan file path, text description, or verbal requirement

**Process:**

1. Parse requirement into logical issues (pattern: data → logic → UI)
2. Determine issue set name from requirement (ask only if ambiguous)
3. Detect repository from git remote (ask if not found: format owner/repo)
4. Generate outcome-focused titles and acceptance criteria
5. Evaluate each issue for technical context (see analyst usage below)
6. Save YAML to `./tmp/issues/{name}-{timestamp}.yml`
7. Report which issues were enriched with analyst context

**Output:**

```
Draft saved: ./tmp/issues/user-search-20251102-143022.yml

Enriched 3 of 4 issues with technical context.

Next: Review file, then refine or publish using publish-github-issues skill.
```

</drafting>

<analyst_usage>

## When to Use Analyst Subagent

**Invoke analyst for:**

- Multiple systems/models (integration)
- Performance/scale requirements (>100 records, <200ms, etc.)
- Security keywords (auth, permissions, tenant, isolation)
- Background jobs, async processing, queues
- New functionality in unfamiliar domain

**Skip analyst for:**

- Standard CRUD (add field, basic form)
- UI-only changes (text, styling, layout)
- Copying existing pattern explicitly

**Analyst request:** "Provide technical breadcrumbs: primary domain, similar patterns, integration points, gotchas (3-5 bullets)"

**Technical Context Format in issue body:**

```yaml
### Technical Context
- Primary domain: [models/controllers]
- Similar pattern: [existing feature]
- Integration points: [connections]
- Consider: [gotcha/constraint]
```

</analyst_usage>

<refinement>

## Refine Draft (Optional)

**Input:** Path to draft YAML file

**Process:**

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

```
Refined tmp/issues/user-search-20251102.yml

Changes:
- Issue #2: Changed title from "Implement SearchService" to "Enable search functionality"
- Issue #3: Added specific acceptance criteria for error handling
- Issue #4: Added technical context (was missing analyst breadcrumbs)

File updated.
```

</refinement>

<yaml_format>

## YAML Structure

See `{baseDir}/references/YAML-FORMAT.md` for complete specification.

**Quick reference:**

- `repository` (required): owner/repo
- `defaults` (optional): labels, milestone
- `issues` (required): array with ref, title, body
- Per-issue optional: parent_ref, milestone, labels

</yaml_format>

## Examples

### Draft from Plan File

**User:** "Draft issues from docs/plans/paddle-integration.md"

```
Reading docs/plans/paddle-integration.md...
Analyzing requirements...
Invoking analyst for technical context (3 of 3 issues)...

Draft saved: tmp/issues/paddle-integration-20251105.yml

Enriched 3 of 3 issues with technical context.

Next: Review file, then publish using publish-github-issues skill.
```

### Draft from Verbal Requirements

**User:** "Draft issues for adding user authentication with OAuth providers"

```
Detecting repository: myorg/myapp
Generating issues...
Invoking analyst for security context...

Draft saved: tmp/issues/user-auth-20251105.yml

Enriched 2 of 3 issues with technical context.

Next: Review file, then publish using publish-github-issues skill.
```

### Refine Draft

**User:** "Refine tmp/issues/paddle-integration-20251105.yml"

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
