# YAML Format Specification

Complete reference for GitHub issue YAML files.

## Top-Level Structure

```yaml
repository: owner/repo  # REQUIRED
project: 6              # OPTIONAL - GitHub project number

defaults:               # OPTIONAL - Default values for all issues
  labels: [label1, label2]
  milestone: "Milestone Name"

issues:                 # REQUIRED - Array of issue definitions
  - ref: issue1
    title: "Issue Title"
    body: "Issue body"
  - ref: issue2
    # ... more issues
```

## Required Fields

### `repository`
- Format: `owner/repo` (e.g., `myorg/myapp`)
- The GitHub repository where issues will be created

### `issues`
- Array of issue objects
- At least one issue required

### Per-Issue Fields

Each issue requires:

**`ref`** (string)
- Unique identifier for this issue within the YAML file
- Used for parent-child linking via `parent_ref`
- Not sent to GitHub (internal reference only)
- Recommended: lowercase with hyphens (e.g., `parent-issue`, `login-feature`)

**`title`** (string)
- Issue title displayed on GitHub
- Keep concise (< 80 characters recommended)
- Should be outcome-focused (WHAT, not HOW)
- Examples:
  - ✅ "Enable search functionality"
  - ❌ "Implement SearchService class"

**`body`** (string, multiline)
- Issue description in Markdown
- Use `|` for multiline content
- Supports GitHub Flavored Markdown

## Optional Fields

### Top-Level Optional

**`project`** (integer)
- GitHub project number (not project name)
- All created issues added to this project

**`defaults`** (object)
- Default values applied to all issues
- Can be overridden per-issue
- Supported: `labels`, `milestone`

### Per-Issue Optional

**`parent_ref`** (string)
- Reference to parent issue's `ref`
- Creates parent-child relationship
- Parent issue must be defined BEFORE child in YAML

**`milestone`** (string)
- Milestone name (exact match required)
- Overrides default milestone if specified

**`labels`** (array of strings)
- Labels to apply
- Overrides default labels if specified
- Labels don't need to exist (GitHub auto-creates)

## Issue Body Format

Standard format for issue bodies:

```markdown
## Overview
Brief description of what needs to be accomplished (the outcome).

## Acceptance Criteria
- [ ] Specific, testable criterion
- [ ] Another testable criterion
- [ ] Final criterion

## Technical Context
- Primary domain: [models/controllers involved]
- Similar pattern: [existing feature to reference]
- Integration points: [connections to other systems]
- Consider: [gotchas, constraints, or performance notes]
```

**Notes:**
- **Overview**: Outcome-focused (what users/system can do after)
- **Acceptance Criteria**: Specific, testable, observable
- **Technical Context**: Optional - add when issue involves integration, performance, security, or unfamiliar domains

## Complete Example

```yaml
repository: myorg/myapp
project: 6

defaults:
  labels: [enhancement]
  milestone: "v2.0"

issues:
  # Parent issue
  - ref: search-feature
    title: "Enable search functionality"
    milestone: "v2.1"  # Override default
    labels: [enhancement, search]
    body: |
      ## Overview
      Add full-text search to allow users to find posts and comments quickly.

      ## Acceptance Criteria
      - [ ] Search bar visible in header on all pages
      - [ ] Results page displays matching posts and comments
      - [ ] Results are paginated (20 per page)
      - [ ] Search works across post titles, bodies, and comments

      ## Technical Context
      - Primary domain: Posts, Comments models; SearchController
      - Similar pattern: Existing filter functionality in app/controllers/posts_controller.rb
      - Consider: PostgreSQL full-text search vs external service (start simple)

  # Child issue 1
  - ref: search-indexing
    parent_ref: search-feature
    title: "Build search indexing"
    body: |
      ## Overview
      Create database indices to support full-text search.

      ## Acceptance Criteria
      - [ ] Migration adds search columns to posts and comments
      - [ ] Background job updates search indices on content changes
      - [ ] Search query returns results in < 200ms for typical queries

      ## Technical Context
      - Primary domain: Posts, Comments models; db/migrate
      - Similar pattern: Existing index patterns in schema.rb
      - Consider: Use PostgreSQL tsvector type, GIN index

  # Child issue 2
  - ref: search-ui
    parent_ref: search-feature
    title: "Build search UI"
    body: |
      ## Overview
      Create user interface for search functionality.

      ## Acceptance Criteria
      - [ ] Search bar component in header
      - [ ] Results page shows post/comment matches with highlighting
      - [ ] Pagination controls (prev/next, page numbers)
      - [ ] Empty state when no results found

      ## Technical Context
      - Primary domain: SearchController, app/views/search
      - Similar pattern: Pagination in app/views/posts/index.html.erb
      - Integration points: Uses search indexing from #search-indexing
```

## Title Guidelines

Titles should describe the outcome, not implementation:

**Good (outcome-focused):**
- "Enable search functionality"
- "Users can filter posts by category"
- "Support OAuth authentication"

**Bad (implementation-focused):**
- "Implement SearchService class"
- "Add filter method to PostsController"
- "Install Devise gem"

## Technical Context Guidelines

Add Technical Context section when issue involves:
- **Integration**: Multiple systems/models working together
- **Performance**: Scale requirements (>100 records, <200ms response)
- **Security**: Auth, permissions, tenant isolation
- **Background processing**: Jobs, queues, async work
- **Unfamiliar domains**: New functionality in unknown territory

Skip Technical Context for:
- Standard CRUD (add field, basic form)
- UI-only changes (text, styling, layout)
- Copying existing pattern explicitly

**Format (3-5 bullets):**
- Primary domain: Where code lives
- Similar pattern: Existing feature to reference
- Integration points: Connections to other parts
- Consider: Gotchas, constraints, performance notes
